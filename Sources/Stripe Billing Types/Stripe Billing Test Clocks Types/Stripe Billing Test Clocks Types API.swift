//
//  Stripe Billing Test Clocks Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.TestClocks {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/test_clocks/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/test_clocks/retrieve.md
        case retrieve(id: Stripe.Billing.TestClocks.TestClock.ID)
        // https://docs.stripe.com/api/test_clocks/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/test_clocks/delete.md
        case delete(id: Stripe.Billing.TestClocks.TestClock.ID)
        // https://docs.stripe.com/api/test_clocks/advance.md
        case advance(id: Stripe.Billing.TestClocks.TestClock.ID, request: Advance.Request)
    }
}

extension Stripe.Billing.TestClocks.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.TestClocks.API> {
            OneOf {
                Route(.case(Stripe.Billing.TestClocks.API.create)) {
                    Method.post
                    Path.v1
                    Path.test_helpers
                    Path.test_clocks
                    Body(
                        .form(
                            Stripe.Billing.TestClocks.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.TestClocks.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.test_helpers
                    Path.test_clocks
                    Path {
                        Parse(.string.representing(Stripe.Billing.TestClocks.TestClock.ID.self))
                    }
                }

                Route(.case(Stripe.Billing.TestClocks.API.list)) {
                    Method.get
                    Path.v1
                    Path.test_helpers
                    Path.test_clocks
                    Parse(.memberwise(Stripe.Billing.TestClocks.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Billing.TestClocks.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.test_helpers
                    Path.test_clocks
                    Path {
                        Parse(.string.representing(Stripe.Billing.TestClocks.TestClock.ID.self))
                    }
                }

                Route(.case(Stripe.Billing.TestClocks.API.advance)) {
                    Method.post
                    Path.v1
                    Path.test_helpers
                    Path.test_clocks
                    Path {
                        Parse(.string.representing(Stripe.Billing.TestClocks.TestClock.ID.self))
                    }
                    Path.advance
                    Body(
                        .form(
                            Stripe.Billing.TestClocks.Advance.Request.self,
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
    public static var test_helpers: Path<PathBuilder.Component<String>> { Path {
        "test_helpers"
    } }

    public static var test_clocks: Path<PathBuilder.Component<String>> { Path {
        "test_clocks"
    } }

    public static var advance: Path<PathBuilder.Component<String>> { Path {
        "advance"
    } }
}
