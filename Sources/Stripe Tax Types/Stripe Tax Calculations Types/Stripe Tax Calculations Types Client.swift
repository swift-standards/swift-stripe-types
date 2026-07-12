//
//  Stripe Tax Calculations Types Client.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Tax.Calculations {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/tax/calculations/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(any Swift.Error) -> Stripe.Tax.Calculation

        // https://docs.stripe.com/api/tax/calculations/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Tax.Calculation.ID) async throws(any Swift.Error) -> Stripe.Tax.Calculation

        // https://docs.stripe.com/api/tax/calculations/line_items.md
        public var listLineItems:
            @Sendable (_ id: Stripe.Tax.Calculation.ID, _ request: List.LineItems.Request)
                async throws(any Swift.Error) ->
                List.LineItems.Response
    }
}
