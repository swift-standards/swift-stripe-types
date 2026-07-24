//
//  Stripe Events Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Events_Types
@testable import Stripe_Types_Models

@Suite("Events Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct EventsRouterTests {

    @Test("Creates correct URL for event retrieval")
    func testRetrieveEventURL() throws {
        let router: Stripe.Events.API.Router = .init()

        let id = try #require(Stripe.Events.Event.ID(rawValue: "evt_123"))
        let api: Stripe.Events.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/events/evt_123")

        // Round-trip test
        let match: Stripe.Events.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Events.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for listing events")
    func testListEventsURL() throws {
        let router: Stripe.Events.API.Router = .init()

        let listRequest = Stripe.Events.List.Request(
            deliverySuccess: true,
            limit: 10,
            type: "charge.succeeded"
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/events")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["delivery_success"] == "true")
        #expect(queryDict["type"] == "charge.succeeded")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveEventMethod() throws {
        let router: Stripe.Events.API.Router = .init()

        let id = try #require(Stripe.Events.Event.ID(rawValue: "evt_456"))
        let api: Stripe.Events.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles GET method correctly for list")
    func testListEventsMethod() throws {
        let router: Stripe.Events.API.Router = .init()

        let listRequest = Stripe.Events.List.Request(limit: 5)
        let api: Stripe.Events.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Tests list with date filter")
    func testListWithDateFilter() throws {
        let router: Stripe.Events.API.Router = .init()

        let listRequest = Stripe.Events.List.Request(
            created: Stripe.DateFilter(gt: 1_609_459_200),
            limit: 5
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/events")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] != nil)
        #expect(queryDict["limit"] == "5")
    }

    @Test("Tests list with types array")
    func testListWithTypesArray() throws {
        let router: Stripe.Events.API.Router = .init()

        let listRequest = Stripe.Events.List.Request(
            types: ["charge.succeeded", "payment_intent.succeeded"]
        )

        // Note: URLRouting doesn't currently support array query parameters in the format
        // Stripe expects (types[]=value or types[0]=value). The types field is handled
        // separately in the live implementation rather than through URLRouting.
        // This test verifies the basic request structure works.

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/events")

        // Types array is not encoded in the URL by the router
        // It's handled separately in the live implementation
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []

        // The types array won't appear in the query items from URLRouting
        // This is expected behavior - the live implementation handles it
        #expect(!queryItems.contains { $0.name == "types" || $0.name.starts(with: "types[") })
    }
}

// §A9 toolchain gate (swift-institute/Research/swift-compiler-bug-catalog.md §A9):
// institute `Tagged` materialized inside this router's deep generic parser chains
// forces its value-witness table at first parse/print; on Swift 6.3.x
// `swift_getTypeByMangledName` returns null metadata and the test runner SIGSEGVs.
// Fixed in Swift 6.4; no source fix exists (graph-package ratified pattern —
// `.disabled(if:)`, not `withKnownIssue`, because the crash kills the runner).
// Auto-retires at the 6.4 toolchain move.
#if compiler(<6.4)
private let taggedMetadataSIGSEGV = true
#else
private let taggedMetadataSIGSEGV = false
#endif
