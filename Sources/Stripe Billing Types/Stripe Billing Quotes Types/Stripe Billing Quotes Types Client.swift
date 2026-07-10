//
//  Stripe Billing Quotes Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Quotes {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/quotes/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Quotes.Create.Request) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/retrieve.md
        public var retrieve: @Sendable (_ id: Stripe.Billing.Quote.ID) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Quotes.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Quotes.List.Response

        // https://docs.stripe.com/api/quotes/accept.md
        public var accept:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.Accept.Request
            ) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/cancel.md
        public var cancel:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.Cancel.Request
            ) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/finalize.md
        public var finalize:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.Finalize.Request
            ) async throws(Witness.Unimplemented.Error) -> Quote

        // https://docs.stripe.com/api/quotes/pdf.md
        public var pdf: @Sendable (_ id: Stripe.Billing.Quotes.Quote.ID) async throws(Witness.Unimplemented.Error) -> Data

        // https://docs.stripe.com/api/quotes/line_items.md
        public var listLineItems:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.List.LineItems.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Quotes.List.LineItems.Response

        // https://docs.stripe.com/api/quotes/computed_upfront_line_items.md
        public var listComputedUpfrontLineItems:
            @Sendable (
                _ id: Stripe.Billing.Quotes.Quote.ID,
                _ request: Stripe.Billing.Quotes.List.ComputedUpfrontLineItems.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Quotes.List.ComputedUpfrontLineItems.Response
    }
}
