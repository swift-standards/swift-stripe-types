//
//  Stripe Billing Invoice Items Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.InvoiceItems {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/invoiceitems/create.md
        case create(request: Stripe.Billing.InvoiceItems.Create.Request)
        // https://docs.stripe.com/api/invoiceitems/retrieve.md
        case retrieve(id: Stripe.Billing.Invoice.Item.ID)
        // https://docs.stripe.com/api/invoiceitems/update.md
        case update(
            id: Stripe.Billing.Invoice.Item.ID,
            request: Stripe.Billing.InvoiceItems.Update.Request
        )
        // https://docs.stripe.com/api/invoiceitems/list.md
        case list(request: Stripe.Billing.InvoiceItems.List.Request)
        // https://docs.stripe.com/api/invoiceitems/delete.md
        case delete(id: Stripe.Billing.Invoice.Item.ID)
    }
}

extension Stripe.Billing.InvoiceItems.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.InvoiceItems.API> {
            OneOf {
                // https://docs.stripe.com/api/invoiceitems/create.md
                URLRouting.Route(.case(Stripe.Billing.InvoiceItems.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.invoiceitems
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.InvoiceItems.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoiceitems/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.InvoiceItems.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.invoiceitems
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.Item.ID.self)) }
                }

                // https://docs.stripe.com/api/invoiceitems/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.InvoiceItems.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.invoiceitems
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.Item.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.InvoiceItems.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoiceitems/list.md
                URLRouting.Route(.case(Stripe.Billing.InvoiceItems.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.invoiceitems
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.InvoiceItems.List.Request.init,
                                { ($0.created, $0.customer, $0.endingBefore, $0.invoice, $0.limit, $0.pending, $0.startingAfter) }
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
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("invoice") {
                                    Parse(.string.representing(Stripe.Billing.Invoice.ID.self))
                                }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("pending") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/invoiceitems/delete.md
                URLRouting.Route(.case(Stripe.Billing.InvoiceItems.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.invoiceitems
                    Path { Parse(.string.representing(Stripe.Billing.Invoice.Item.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var invoiceitems: Path<PathBuilder.Component<String>> { Path {
        "invoiceitems"
    } }
}
