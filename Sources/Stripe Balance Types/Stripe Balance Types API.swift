//
//  Stripe Balance Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Balance {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/balance/retrieve.md
        case retrieve
    }
}

extension Stripe.Balance.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Balance.API> {
            OneOf {
                // https://docs.stripe.com/api/balance/retrieve.md
                URLRouting.Route(.case(Stripe.Balance.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.balance
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var balance: Path<PathBuilder.Component<String>> { Path {
        "balance"
    } }
}
