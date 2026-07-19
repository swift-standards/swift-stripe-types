//
//  Expandable Tests.swift
//  swift-stripe-types
//
//  Regression coverage for F-008: `Expandable`'s `init(from:)` guards its
//  typeMismatch fallback with `where type is ID.Type`. When `ID` is a wrapper
//  type such as `Tagged<Tag, String>`, the decoder reports the mismatch
//  against the wrapper's *underlying* wire type (`String.self`), never
//  against `ID.self` itself — so the guard never matches and decoding an
//  expanded-object payload throws instead of falling back to `Model`.
//
//  `Fixture.ID` mirrors every production `@ExpandableOf` usage in this
//  package (e.g. `Stripe.Customers.Customer.ID`, `Stripe.Charges.Charge.ID`):
//  a `Tagged<Self, String>`.

import Foundation
import Tagged_Primitives
import Testing

@testable import Stripe_Types_Shared

// `Expandable<Model, ID>` is a generic namespace — the canonical
// `extension Expandable { @Suite struct Tests {} }` shape does not compile
// (the `@Suite` macro emits a static stored property, illegal inside a
// generic type). Per the testing-institute generic-namespace carve-out, this
// uses the top-level `@Suite("Name") struct Tests` shape instead.
@Suite("Expandable")
struct Tests {
    /// Mirrors a real Stripe model with a `Tagged<Self, String>` id, matching
    /// the ~50 production `@ExpandableOf<Model>` call sites in this package.
    struct Fixture: Codable, Identifiable, Equatable, Sendable {
        typealias ID = Tagged<Fixture, String>
        let id: ID
        let name: String
    }

    @Suite
    struct Unit {
        @Test("Decodes an unexpanded id-only payload when the ID is a Tagged wrapper")
        func decodesUnexpandedTaggedID() throws {
            let json = Data(#""fx_123""#.utf8)

            let value = try JSONDecoder().decode(ExpandableOf<Fixture>.self, from: json)

            #expect(value.wrappedValue == Fixture.ID(rawValue: "fx_123"))
            #expect(value.projectedValue == nil)
        }

        @Test("Decodes an expanded-object payload when the ID is a Tagged wrapper")
        func decodesExpandedObjectWithTaggedID() throws {
            let json = Data(#"{"id":"fx_123","name":"Widget"}"#.utf8)

            let value = try JSONDecoder().decode(ExpandableOf<Fixture>.self, from: json)

            let expectedID = try #require(Fixture.ID(rawValue: "fx_123"))
            #expect(value.projectedValue == Fixture(id: expectedID, name: "Widget"))
            #expect(value.wrappedValue == nil)
        }

        @Test("Round-trips an expanded-object payload through encode")
        func encodesExpandedModelWithTaggedID() throws {
            let expectedID = try #require(Fixture.ID(rawValue: "fx_123"))
            let expanded = Expandable<Fixture, Fixture.ID>(model: Fixture(id: expectedID, name: "Widget"))

            let data = try JSONEncoder().encode(expanded)
            let decoded = try JSONDecoder().decode(ExpandableOf<Fixture>.self, from: data)

            #expect(decoded.projectedValue == Fixture(id: expectedID, name: "Widget"))
        }
    }

    @Suite
    struct `Edge Case` {
        @Test("ExpandableCollection still decodes an array of Tagged-ID models")
        func expandableCollectionDecodesExpandedModelsWithTaggedID() throws {
            let json = Data(#"[{"id":"fx_1","name":"A"},{"id":"fx_2","name":"B"}]"#.utf8)

            let value = try JSONDecoder().decode(ExpandableCollection<Fixture>.self, from: json)

            #expect(value.projectedValue?.map(\.name) == ["A", "B"])
            #expect(value.wrappedValue == nil)
        }

        @Test("ExpandableCollection still decodes an array of unexpanded Tagged ids")
        func expandableCollectionDecodesUnexpandedTaggedIDs() throws {
            let json = Data(#"["fx_1","fx_2"]"#.utf8)

            let value = try JSONDecoder().decode(ExpandableCollection<Fixture>.self, from: json)

            #expect(value.wrappedValue == ["fx_1", "fx_2"])
            #expect(value.projectedValue == nil)
        }
    }
}
