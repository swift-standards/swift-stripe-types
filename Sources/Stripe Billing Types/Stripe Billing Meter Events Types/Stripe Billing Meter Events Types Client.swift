//
//  Stripe Billing Meter Events Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.MeterEvents {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/meter-event/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.MeterEvents.Create.Request) async throws(Witness.Unimplemented.Error) ->
                MeterEvent
    }
}
