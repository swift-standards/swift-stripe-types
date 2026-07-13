//
//  Stripe Billing Invoices Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.Invoices {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/invoices/create.md
        case create(request: Stripe.Billing.Invoices.Create.Request)
        // https://docs.stripe.com/api/invoices/create_preview.md
        case createPreview(request: Stripe.Billing.Invoices.CreatePreview.Request)
        // https://docs.stripe.com/api/invoices/retrieve.md
        case retrieve(id: Stripe.Billing.Invoice.ID)
        // https://docs.stripe.com/api/invoices/update.md
        case update(id: Stripe.Billing.Invoice.ID, request: Stripe.Billing.Invoices.Update.Request)
        // https://docs.stripe.com/api/invoices/list.md
        case list(request: Stripe.Billing.Invoices.List.Request)
        // https://docs.stripe.com/api/invoices/delete.md
        case delete(id: Stripe.Billing.Invoice.ID)
        // https://docs.stripe.com/api/invoices/finalize_invoice.md
        case finalize(
            id: Stripe.Billing.Invoice.ID,
            request: Stripe.Billing.Invoices.Finalize.Request
        )
        // https://docs.stripe.com/api/invoices/pay.md
        case pay(id: Stripe.Billing.Invoice.ID, request: Stripe.Billing.Invoices.Pay.Request)
        // https://docs.stripe.com/api/invoices/send.md
        case send(id: Stripe.Billing.Invoice.ID, request: Stripe.Billing.Invoices.Send.Request)
        // https://docs.stripe.com/api/invoices/void.md
        case void(id: Stripe.Billing.Invoice.ID, request: Stripe.Billing.Invoices.Void.Request)
    }
}

extension Stripe.Billing.Invoices.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Invoices.API> {
            OneOf {
                // https://docs.stripe.com/api/invoices/create.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/create_preview.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.cases.createPreview)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path.createPreview
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.CreatePreview.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                }

                // https://docs.stripe.com/api/invoices/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Invoices.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/list.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.invoices
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0.0.0, $0.0.0.0.0.0.0.0.1, $0.0.0.0.0.0.0.1, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6), $0.7), $0.8) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Invoices.List.Request.init,
                                { ($0.collectionMethod, $0.created, $0.customer, $0.dueDate, $0.endingBefore, $0.limit, $0.startingAfter, $0.status, $0.subscription) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("collection_method") {
                                    Parse(
                                        .string.representing(
                                            Stripe.Billing.Invoice.CollectionMethod.self
                                        )
                                    )
                                }
                            }
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
                                Field("due_date") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
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
                            Optionally {
                                Field("status") {
                                    Parse(.string.representing(Stripe.Billing.Invoice.Status.self))
                                }
                            }
                            Optionally {
                                Field("subscription") {
                                    Parse(.string.representing(Stripe.Billing.Subscription.ID.self))
                                }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/invoices/delete.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                }

                // https://docs.stripe.com/api/invoices/finalize_invoice.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Invoices.API.cases.finalize))) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.finalize
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Finalize.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/pay.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Invoices.API.cases.pay))) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.pay
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Pay.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/send.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Invoices.API.cases.send))) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.send
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Send.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/void.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Invoices.API.cases.void))) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.void
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Invoices.Void.Request.self,
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
    public static var invoices: Path<PathBuilder.Component<String>> { Path {
        "invoices"
    } }

    public static var createPreview: Path<PathBuilder.Component<String>> { Path {
        "create_preview"
    } }

    public static var finalize: Path<PathBuilder.Component<String>> { Path {
        "finalize"
    } }

    public static var pay: Path<PathBuilder.Component<String>> { Path {
        "pay"
    } }

    public static var send: Path<PathBuilder.Component<String>> { Path {
        "send"
    } }

    public static var void: Path<PathBuilder.Component<String>> { Path {
        "void"
    } }
}
