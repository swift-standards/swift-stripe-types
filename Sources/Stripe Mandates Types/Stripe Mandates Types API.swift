//
//  Stripe Mandates Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Mandates {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/mandates/retrieve.md
        case retrieve(id: Stripe.Mandates.Mandate.ID)
    }
}

extension Stripe.Mandates.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Mandates.API> {
            OneOf {
                // https://docs.stripe.com/api/mandates/retrieve.md
                URLRouting.Route(.case(Stripe.Mandates.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.mandates
                    Path { Parse(.string.representing(Stripe.Mandates.Mandate.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var mandates: Path<PathBuilder.Component<String>> { Path {
        "mandates"
    } }
}
