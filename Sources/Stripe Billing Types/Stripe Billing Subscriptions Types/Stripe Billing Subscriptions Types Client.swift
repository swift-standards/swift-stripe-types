//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Subscriptions {
    @Witness
    public struct Client: Sendable {

        // https://docs.stripe.com/api/subscriptions/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Subscriptions.Create.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Subscription

        // https://docs.stripe.com/api/subscriptions/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Subscription.ID,
                _ request: Stripe.Billing.Subscriptions.Update.Request
            ) async throws(any Swift.Error) -> Stripe.Billing.Subscription

        // https://docs.stripe.com/api/subscriptions/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Subscription.ID) async throws(any Swift.Error) ->
                Stripe.Billing.Subscription

        // https://docs.stripe.com/api/subscriptions/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Subscriptions.List.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Subscriptions.List.Response

        // https://docs.stripe.com/api/subscriptions/cancel.md
        public var cancel:
            @Sendable (
                _ id: Stripe.Billing.Subscription.ID,
                _ request: Stripe.Billing.Subscriptions.Cancel.Request
            ) async throws(any Swift.Error) -> Stripe.Billing.Subscription
    }
}
