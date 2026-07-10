//
//  Stripe Billing Subscription Schedule Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Subscription.Schedule {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/subscription_schedules/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Subscription.Schedule.Create.Request) async throws(Witness.Unimplemented.Error)
                ->
                Stripe.Billing.Subscription.Schedule

        // https://docs.stripe.com/api/subscription_schedules/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Subscription.Schedule.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Subscription.Schedule

        // https://docs.stripe.com/api/subscription_schedules/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Subscription.Schedule.ID,
                _ request: Stripe.Billing.Subscription.Schedule.Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Subscription.Schedule

        // https://docs.stripe.com/api/subscription_schedules/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Subscription.Schedule.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Subscription.Schedule.List.Response

        // https://docs.stripe.com/api/subscription_schedules/cancel.md
        public var cancel:
            @Sendable (
                _ id: Stripe.Billing.Subscription.Schedule.ID,
                _ request: Stripe.Billing.Subscription.Schedule.Cancel.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Subscription.Schedule

        // https://docs.stripe.com/api/subscription_schedules/release.md
        public var release:
            @Sendable (
                _ id: Stripe.Billing.Subscription.Schedule.ID,
                _ request: Stripe.Billing.Subscription.Schedule.Release.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Subscription.Schedule
    }
}
