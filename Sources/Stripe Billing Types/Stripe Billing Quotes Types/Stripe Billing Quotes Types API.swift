//
//  Stripe Billing Quotes Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Quotes {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.Billing.Quotes.API.create)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Body(
                        .form(
                            Stripe.Billing.Quotes.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                }

                Route(.case(Stripe.Billing.Quotes.API.update)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Quotes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.list)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Parse(.memberwise(Stripe.Billing.Quotes.List.Request.init)) {
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
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Billing.Quotes.API.accept)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.accept
                    Body(
                        .form(
                            Stripe.Billing.Quotes.Accept.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.cancel)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.quotes_cancel
                    Body(
                        .form(
                            Stripe.Billing.Quotes.Cancel.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.finalize)) {
                    Method.post
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.quotes_finalize
                    Body(
                        .form(
                            Stripe.Billing.Quotes.Finalize.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Quotes.API.pdf)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.pdf
                }

                Route(.case(Stripe.Billing.Quotes.API.listLineItems)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.line_items
                    Parse(.memberwise(Stripe.Billing.Quotes.List.LineItems.Request.init)) {
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

                Route(.case(Stripe.Billing.Quotes.API.listComputedUpfrontLineItems)) {
                    Method.get
                    Path.v1
                    Path.quotes
                    Path { Parse(.string.representing(Stripe.Billing.Quotes.Quote.ID.self)) }
                    Path.computed_upfront_line_items
                    Parse(
                        .memberwise(
                            Stripe.Billing.Quotes.List.ComputedUpfrontLineItems.Request.init
                        )
                    ) {
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
