//
//  Stripe Charges Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Charges {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/charges/create.md
        case create(request: Stripe.Charges.Create.Request)
        // https://docs.stripe.com/api/charges/retrieve.md
        case retrieve(id: Stripe.Charges.Charge.ID)
        // https://docs.stripe.com/api/charges/update.md
        case update(id: Stripe.Charges.Charge.ID, request: Stripe.Charges.Update.Request)
        // https://docs.stripe.com/api/charges/list.md
        case list(request: Stripe.Charges.List.Request)
        // https://docs.stripe.com/api/charges/capture.md
        case capture(id: Stripe.Charges.Charge.ID, request: Stripe.Charges.Capture.Request)
        // https://docs.stripe.com/api/charges/search.md
        case search(request: Stripe.Charges.Search.Request)
    }
}

extension Stripe.Charges.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Charges.API> {
            OneOf {
                // https://docs.stripe.com/api/charges/create.md
                URLRouting.Route(.case(Stripe.Charges.API.create)) {
                    Method.post
                    Path.v1
                    Path.charges
                    Body(
                        .form(
                            Stripe.Charges.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/retrieve.md
                URLRouting.Route(.case(Stripe.Charges.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                }

                // https://docs.stripe.com/api/charges/update.md
                URLRouting.Route(.case(Stripe.Charges.API.update)) {
                    Method.post
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                    Body(
                        .form(
                            Stripe.Charges.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/list.md
                URLRouting.Route(.case(Stripe.Charges.API.list)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Parse(.memberwise(Stripe.Charges.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
                            }
                            Optionally {
                                Field("payment_intent") {
                                    Parse(
                                        .string.representing(
                                            Stripe.PaymentIntents.PaymentIntent.ID.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("transfer_group") { Parse(.string) }
                            }
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

                // https://docs.stripe.com/api/charges/capture.md
                URLRouting.Route(.case(Stripe.Charges.API.capture)) {
                    Method.post
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                    Path { "capture" }
                    Body(
                        .form(
                            Stripe.Charges.Capture.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/search.md
                URLRouting.Route(.case(Stripe.Charges.API.search)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Path { "search" }
                    Parse(.memberwise(Stripe.Charges.Search.Request.init)) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("page") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var charges: Path<PathBuilder.Component<String>> { Path {
        "charges"
    } }
}
