//
//  Stripe Connect Account Session Types API.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Connect.Account.Session {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/account_sessions/create.md
        case create(request: Create.Request)
    }
}

extension Stripe.Connect.Account.Session.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Connect.Account.Session.API> {
            OneOf {
                Route(.case(Stripe.Connect.Account.Session.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.accountSessions
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Account.Session.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var accountSessions: Path<PathBuilder.Component<String>> { Path {
        "account_sessions"
    } }
}
