//
//  Stripe Setup Intents Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Setup.Intents {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/setup_intents/create.md
        public var create:
            @Sendable (_ request: Stripe.Setup.Intents.Create.Request) async throws(any Swift.Error) ->
                Stripe.Setup.Intent

        // https://docs.stripe.com/api/setup_intents/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Setup.Intent.ID) async throws(any Swift.Error) -> Stripe.Setup.Intent

        // https://docs.stripe.com/api/setup_intents/update.md
        public var update:
            @Sendable (_ id: Stripe.Setup.Intent.ID, _ request: Stripe.Setup.Intents.Update.Request)
                async throws(any Swift.Error) -> Stripe.Setup.Intent

        // https://docs.stripe.com/api/setup_intents/list.md
        public var list:
            @Sendable (_ request: Stripe.Setup.Intents.List.Request) async throws(any Swift.Error) ->
                Stripe.Setup.Intents.List.Response

        // https://docs.stripe.com/api/setup_intents/confirm.md
        public var confirm:
            @Sendable (
                _ id: Stripe.Setup.Intent.ID, _ request: Stripe.Setup.Intents.Confirm.Request
            )
                async throws(any Swift.Error) -> Stripe.Setup.Intent

        // https://docs.stripe.com/api/setup_intents/cancel.md
        public var cancel:
            @Sendable (_ id: Stripe.Setup.Intent.ID, _ request: Stripe.Setup.Intents.Cancel.Request)
                async throws(any Swift.Error) -> Stripe.Setup.Intent

        // https://docs.stripe.com/api/setup_intents/verify_microdeposits.md
        public var verifyMicrodeposits:
            @Sendable (
                _ id: Stripe.Setup.Intent.ID,
                _ request: Stripe.Setup.Intents.VerifyMicrodeposits.Request
            ) async throws(any Swift.Error) -> Stripe.Setup.Intent
    }
}
