//
//  Stripe Billing Meters Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Meters {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/meter/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Meters.Create.Request) async throws(any Swift.Error) -> Meter

        // https://docs.stripe.com/api/billing/meter/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Meters.Meter.ID) async throws(any Swift.Error) ->
                Stripe.Billing.Meters.Meter

        // https://docs.stripe.com/api/billing/meter/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Meters.Meter.ID,
                _ request: Stripe.Billing.Meters.Update.Request
            ) async throws(any Swift.Error) -> Meter

        // https://docs.stripe.com/api/billing/meter/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Meters.List.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Meters.List.Response

        // https://docs.stripe.com/api/billing/meter/deactivate.md
        public var deactivate:
            @Sendable (
                _ id: Stripe.Billing.Meters.Meter.ID,
                _ request: Stripe.Billing.Meters.Deactivate.Request
            ) async throws(any Swift.Error) -> Meter

        // https://docs.stripe.com/api/billing/meter/reactivate.md
        public var reactivate:
            @Sendable (
                _ id: Stripe.Billing.Meters.Meter.ID,
                _ request: Stripe.Billing.Meters.Reactivate.Request
            ) async throws(any Swift.Error) -> Meter
    }
}
