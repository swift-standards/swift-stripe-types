//
//  Stripe Billing Invoice Line Item Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Invoice.LineItems {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/invoice-line-item/retrieve.md
        case list(invoiceId: String, request: Stripe.Billing.Invoice.LineItems.List.Request)
        // https://docs.stripe.com/api/invoice-line-item/update.md
        case update(
            invoiceId: String,
            lineItemId: String,
            request: Stripe.Billing.Invoice.LineItems.Update.Request
        )
        // https://docs.stripe.com/api/invoice-line-item/bulk.md
        case addLines(invoiceId: String, request: Stripe.Billing.Invoice.LineItems.AddLines.Request)
        // https://docs.stripe.com/api/invoice-line-item/bulk-update.md
        case updateLines(
            invoiceId: String,
            request: Stripe.Billing.Invoice.LineItems.UpdateLines.Request
        )
        // https://docs.stripe.com/api/invoice-line-item/invoices/remove-lines/bulk.md
        case removeLines(
            invoiceId: String,
            request: Stripe.Billing.Invoice.LineItems.RemoveLines.Request
        )
    }
}

extension Stripe.Billing.Invoice.LineItems.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Invoice.LineItems.API> {
            OneOf {
                // https://docs.stripe.com/api/invoice-line-item/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Invoice.LineItems.API.list)) {
                    Method.get
                    Path.v1
                    Path.invoices
                    Path { Parse(.string) }
                    Path.lines
                    Parse(.memberwise(Stripe.Billing.Invoice.LineItems.List.Request.init)) {
                        URLRouting.Query {
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

                // https://docs.stripe.com/api/invoice-line-item/update.md
                URLRouting.Route(.case(Stripe.Billing.Invoice.LineItems.API.update)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string) }
                    Path.lines
                    Path { Parse(.string) }
                    Body(
                        .form(
                            Stripe.Billing.Invoice.LineItems.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoice-line-item/bulk.md
                URLRouting.Route(.case(Stripe.Billing.Invoice.LineItems.API.addLines)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string) }
                    Path.add_lines
                    Body(
                        .form(
                            Stripe.Billing.Invoice.LineItems.AddLines.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoice-line-item/bulk-update.md
                URLRouting.Route(.case(Stripe.Billing.Invoice.LineItems.API.updateLines)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string) }
                    Path.update_lines
                    Body(
                        .form(
                            Stripe.Billing.Invoice.LineItems.UpdateLines.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/invoice-line-item/invoices/remove-lines/bulk.md
                URLRouting.Route(.case(Stripe.Billing.Invoice.LineItems.API.removeLines)) {
                    Method.post
                    Path.v1
                    Path.invoices
                    Path { Parse(.string) }
                    Path.remove_lines
                    Body(
                        .form(
                            Stripe.Billing.Invoice.LineItems.RemoveLines.Request.self,
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
    public static var lines: Path<PathBuilder.Component<String>> { Path {
        "lines"
    } }

    public static var add_lines: Path<PathBuilder.Component<String>> { Path {
        "add_lines"
    } }

    public static var update_lines: Path<PathBuilder.Component<String>> { Path {
        "update_lines"
    } }

    public static var remove_lines: Path<PathBuilder.Component<String>> { Path {
        "remove_lines"
    } }
}
