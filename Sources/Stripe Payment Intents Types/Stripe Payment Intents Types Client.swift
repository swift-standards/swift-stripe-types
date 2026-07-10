//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 04/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.PaymentIntents {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/payment_intents/create.md
        public var create:
            @Sendable (_ request: Stripe.PaymentIntents.Create.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/update.md
        public var update:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID)
                async throws(Witness.Unimplemented.Error) ->
                Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/list.md
        public var list:
            @Sendable (_ request: Stripe.PaymentIntents.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentIntents.List.Response

        // https://docs.stripe.com/api/payment_intents/cancel.md
        public var cancel:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.Cancel.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/capture.md
        public var capture:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.Capture.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/confirm.md
        public var confirm:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.Confirm.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/increment_authorization.md
        public var incrementAuthorization:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.IncrementAuthorization.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/apply_customer_balance.md
        public var applyCustomerBalance:
            @Sendable (_ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID)
                async throws(Witness.Unimplemented.Error) ->
                Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent

        // https://docs.stripe.com/api/payment_intents/search.md
        public var search:
            @Sendable (_ request: Stripe.PaymentIntents.Search.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentIntents.Search.Response

        // https://docs.stripe.com/api/payment_intents/verify_microdeposits.md
        public var verifyMicrodeposits:
            @Sendable (
                _ id: Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent.ID,
                _ request: Stripe.PaymentIntents.VerifyMicrodeposits.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Shared.Stripe.PaymentIntents.PaymentIntent
    }
}
