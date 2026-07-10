//
//  Stripe Billing Invoices Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Invoices {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/invoices/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Invoices.Create.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/create_preview.md
        public var createPreview:
            @Sendable (_ request: Stripe.Billing.Invoices.CreatePreview.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Invoice.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Invoice.ID, _ request: Stripe.Billing.Invoices.Update.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Invoices.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Invoices.List.Response

        // https://docs.stripe.com/api/invoices/delete.md
        public var delete:
            @Sendable (_ id: Stripe.Billing.Invoice.ID) async throws(Witness.Unimplemented.Error) -> DeletedObject<
                Stripe.Billing.Invoice
            >

        // https://docs.stripe.com/api/invoices/finalize_invoice.md
        public var finalize:
            @Sendable (
                _ id: Stripe.Billing.Invoice.ID, _ request: Stripe.Billing.Invoices.Finalize.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/pay.md
        public var pay:
            @Sendable (
                _ id: Stripe.Billing.Invoice.ID, _ request: Stripe.Billing.Invoices.Pay.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/send.md
        public var send:
            @Sendable (
                _ id: Stripe.Billing.Invoice.ID, _ request: Stripe.Billing.Invoices.Send.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice

        // https://docs.stripe.com/api/invoices/void.md
        public var void:
            @Sendable (
                _ id: Stripe.Billing.Invoice.ID, _ request: Stripe.Billing.Invoices.Void.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Invoice
    }
}
