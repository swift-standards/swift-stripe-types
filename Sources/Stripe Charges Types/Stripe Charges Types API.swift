//
//  Stripe Charges Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Charges {
    @Cases
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
                URLRouting.Route(.case(Stripe.Charges.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.charges
                    URLRouting.Body(
                        .form(
                            Stripe.Charges.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/retrieve.md
                URLRouting.Route(.case(Stripe.Charges.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                }

                // https://docs.stripe.com/api/charges/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Charges.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Charges.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/list.md
                URLRouting.Route(.case(Stripe.Charges.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Charges.List.Request.init,
                                { ($0.created, $0.customer, $0.paymentIntent, $0.transferGroup, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
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
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/charges/capture.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Charges.API.cases.capture))) {
                    Method.post
                    Path.v1
                    Path.charges
                    Path { Parse(.string.representing(Stripe.Charges.Charge.ID.self)) }
                    Path { "capture" }
                    URLRouting.Body(
                        .form(
                            Stripe.Charges.Capture.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/charges/search.md
                URLRouting.Route(.case(Stripe.Charges.API.cases.search)) {
                    Method.get
                    Path.v1
                    Path.charges
                    Path { "search" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Charges.Search.Request.init,
                                { ($0.query, $0.limit, $0.page) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Int.parser() }
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
