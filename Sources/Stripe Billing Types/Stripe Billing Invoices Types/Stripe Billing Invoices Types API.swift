//
//  Stripe Billing Invoices Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Invoices {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.create)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Body(
                        .form(
                            Stripe.Billing.Invoices.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/create_preview.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.createPreview)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path.createPreview
                    Body(
                        .form(
                            Stripe.Billing.Invoices.CreatePreview.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                }

                // https://docs.stripe.com/api/invoices/update.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.update)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Invoices.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/list.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.list)) {
                    Method.get
                    Path.v1
                    Path.invoices
                    Parse(.memberwise(Stripe.Billing.Invoices.List.Request.init)) {
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
                                Field("limit") { Digits() }
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
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                }

                // https://docs.stripe.com/api/invoices/finalize_invoice.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.finalize)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.finalize
                    Body(
                        .form(
                            Stripe.Billing.Invoices.Finalize.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/pay.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.pay)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.pay
                    Body(
                        .form(
                            Stripe.Billing.Invoices.Pay.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/send.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.send)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.send
                    Body(
                        .form(
                            Stripe.Billing.Invoices.Send.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoices/void.md
                URLRouting.Route(.case(Stripe.Billing.Invoices.API.void)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.ID.self)) }
                    Path.void
                    Body(
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
