//
//  Stripe Products Tax Rate Types Client.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Products.TaxRates {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/tax_rates/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.Tax.Rate

        // https://docs.stripe.com/api/tax_rates/retrieve.md
        public var retrieve: @Sendable (_ id: Stripe.Tax.Rate.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Tax.Rate

        // https://docs.stripe.com/api/tax_rates/update.md
        public var update:
            @Sendable (_ id: Stripe.Tax.Rate.ID, _ request: Update.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Tax.Rate

        // https://docs.stripe.com/api/tax_rates/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response
    }
}
