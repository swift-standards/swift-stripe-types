//
//  Stripe Billing Quotes Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.Quotes {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/quotes/create.md
        case create(request: Create.Request)

        // https://docs.stripe.com/api/quotes/retrieve.md
        case retrieve(id: Stripe.Billing.Quotes.Quote.ID)

        // https://docs.stripe.com/api/quotes/update.md
        case update(id: Stripe.Billing.Quotes.Quote.ID, request: Update.Request)

        // https://docs.stripe.com/api/quotes/list.md
        case list(request: List.Request)

        // https://docs.stripe.com/api/quotes/accept.md
        case accept(id: Stripe.Billing.Quotes.Quote.ID, request: Accept.Request)

        // https://docs.stripe.com/api/quotes/cancel.md
        case cancel(id: Stripe.Billing.Quotes.Quote.ID, request: Cancel.Request)

        // https://docs.stripe.com/api/quotes/finalize.md
        case finalize(id: Stripe.Billing.Quotes.Quote.ID, request: Finalize.Request)

        // https://docs.stripe.com/api/quotes/pdf.md
        case pdf(id: Stripe.Billing.Quotes.Quote.ID)

        // https://docs.stripe.com/api/quotes/line_items.md
        case listLineItems(id: Stripe.Billing.Quotes.Quote.ID, request: List.LineItems.Request)

        // https://docs.stripe.com/api/quotes/computed_upfront_line_items.md
        case listComputedUpfrontLineItems(
            id: Stripe.Billing.Quotes.Quote.ID,
            request: List.ComputedUpfrontLineItems.Request
        )
    }
}

extension Stripe.Billing.Quotes.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Quotes.API> {
            OneOf {
                Route(.case(Stripe.Billing.Quotes.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Quotes.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Quotes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Quotes.List.Request.init,
                                { ($0.customer, $0.status, $0.testClock, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
                            }
                            Optionally {
                                Field("status") {
                                    Parse(.string.representing(Stripe.Billing.Quotes.Status.self))
                                }
                            }
                            Optionally {
                                Field("test_clock") { Parse(.string) }
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

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.accept))) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.accept
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Quotes.Accept.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.cancel))) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.quotes_cancel
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Quotes.Cancel.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.finalize))) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.quotes_finalize
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Quotes.Finalize.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.cases.pdf)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.pdf
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.listLineItems))) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.line_items
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Quotes.List.LineItems.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
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

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Quotes.API.cases.listComputedUpfrontLineItems))) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.computed_upfront_line_items
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(Stripe.Billing.Quotes.List.ComputedUpfrontLineItems.Request.init, { ($0.endingBefore, $0.limit, $0.startingAfter) })
                        )
                    ) {
                        Query {
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
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var quotes: Path<PathBuilder.Component<String>> { Path {
        "quotes"
    } }

    public static var accept: Path<PathBuilder.Component<String>> { Path {
        "accept"
    } }

    public static var quotes_cancel: Path<PathBuilder.Component<String>> { Path {
        "cancel"
    } }

    public static var quotes_finalize: Path<PathBuilder.Component<String>> { Path {
        "finalize"
    } }

    public static var pdf: Path<PathBuilder.Component<String>> { Path {
        "pdf"
    } }

    public static var line_items: Path<PathBuilder.Component<String>> { Path {
        "line_items"
    } }

    public static var computed_upfront_line_items: Path<PathBuilder.Component<String>> { Path {
        "computed_upfront_line_items"
    } }
}
