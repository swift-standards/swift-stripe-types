//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 04/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.PaymentIntents {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payment_intents/create.md
        case create(request: Stripe.PaymentIntents.Create.Request)
        // https://docs.stripe.com/api/payment_intents/update.md
        case update(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.Update.Request
        )
        // https://docs.stripe.com/api/payment_intents/retrieve.md
        case retrieve(id: Stripe.PaymentIntents.PaymentIntent.ID)
        // https://docs.stripe.com/api/payment_intents/list.md
        case list(request: Stripe.PaymentIntents.List.Request)
        // https://docs.stripe.com/api/payment_intents/cancel.md
        case cancel(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.Cancel.Request
        )
        // https://docs.stripe.com/api/payment_intents/capture.md
        case capture(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.Capture.Request
        )
        // https://docs.stripe.com/api/payment_intents/confirm.md
        case confirm(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.Confirm.Request
        )
        // https://docs.stripe.com/api/payment_intents/increment_authorization.md
        case incrementAuthorization(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.IncrementAuthorization.Request
        )
        // https://docs.stripe.com/api/payment_intents/apply_customer_balance.md
        case applyCustomerBalance(id: Stripe.PaymentIntents.PaymentIntent.ID)
        // https://docs.stripe.com/api/payment_intents/search.md
        case search(request: Stripe.PaymentIntents.Search.Request)
        // https://docs.stripe.com/api/payment_intents/verify_microdeposits.md
        case verifyMicrodeposits(
            id: Stripe.PaymentIntents.PaymentIntent.ID,
            request: Stripe.PaymentIntents.VerifyMicrodeposits.Request
        )
    }
}

extension Stripe.PaymentIntents.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentIntents.API> {
            OneOf {
                // https://docs.stripe.com/api/payment_intents/create.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.create)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Body(
                        .form(
                            Stripe.PaymentIntents.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/retrieve.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                }

                // https://docs.stripe.com/api/payment_intents/update.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.update)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Body(
                        .form(
                            Stripe.PaymentIntents.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/list.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.list)) {
                    Method.get
                    Path.v1
                    Path.paymentIntents
                    Parse(.memberwise(Stripe.PaymentIntents.List.Request.init)) {
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

                // https://docs.stripe.com/api/payment_intents/cancel.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.cancel)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "cancel" }
                    Body(
                        .form(
                            Stripe.PaymentIntents.Cancel.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/capture.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.capture)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "capture" }
                    Body(
                        .form(
                            Stripe.PaymentIntents.Capture.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/confirm.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.confirm)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "confirm" }
                    Body(
                        .form(
                            Stripe.PaymentIntents.Confirm.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/increment_authorization.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.incrementAuthorization)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "increment_authorization" }
                    Body(
                        .form(
                            Stripe.PaymentIntents.IncrementAuthorization.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment_intents/apply_customer_balance.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.applyCustomerBalance)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "apply_customer_balance" }
                }

                // https://docs.stripe.com/api/payment_intents/search.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.search)) {
                    Method.get
                    Path.v1
                    Path.paymentIntents
                    Path { "search" }
                    Parse(.memberwise(Stripe.PaymentIntents.Search.Request.init)) {
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

                // https://docs.stripe.com/api/payment_intents/verify_microdeposits.md
                URLRouting.Route(.case(Stripe.PaymentIntents.API.verifyMicrodeposits)) {
                    Method.post
                    Path.v1
                    Path.paymentIntents
                    Path {
                        Parse(.string.representing(Stripe.PaymentIntents.PaymentIntent.ID.self))
                    }
                    Path { "verify_microdeposits" }
                    Body(
                        .form(
                            Stripe.PaymentIntents.VerifyMicrodeposits.Request.self,
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
    public static var paymentIntents: Path<PathBuilder.Component<String>> { Path {
        "payment_intents"
    } }
}
