//
//  Stripe Billing Invoice Line Item Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Invoice.LineItems {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/invoice-line-item/retrieve.md
        public var list:
            @Sendable (
                _ invoiceId: String, _ request: Stripe.Billing.Invoice.LineItems.List.Request
            )
                async throws(any Swift.Error) -> Stripe.Billing.Invoice.LineItem.List

        // https://docs.stripe.com/api/invoice-line-item/update.md
        public var update:
            @Sendable (
                _ invoiceId: String, _ lineItemId: String,
                _ request: Stripe.Billing.Invoice.LineItems.Update.Request
            ) async throws(any Swift.Error) -> Stripe.Billing.Invoice.LineItem

        // https://docs.stripe.com/api/invoice-line-item/bulk.md
        public var addLines:
            @Sendable (
                _ invoiceId: String, _ request: Stripe.Billing.Invoice.LineItems.AddLines.Request
            )
                async throws(any Swift.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoice-line-item/bulk-update.md
        public var updateLines:
            @Sendable (
                _ invoiceId: String, _ request: Stripe.Billing.Invoice.LineItems.UpdateLines.Request
            ) async throws(any Swift.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoice-line-item/invoices/remove-lines/bulk.md
        public var removeLines:
            @Sendable (
                _ invoiceId: String, _ request: Stripe.Billing.Invoice.LineItems.RemoveLines.Request
            ) async throws(any Swift.Error) -> Stripe.Billing.Invoice
    }
}
