//
//  Stripe Payment Method Configurations Types Client.swift
//  swift-stripe-types
//
//  Created for swift-stripe-types on 14/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.PaymentMethodConfigurations {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/payment_method_configurations/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(any Swift.Error) ->
                Stripe.PaymentMethodConfigurations.Configuration

        // https://docs.stripe.com/api/payment_method_configurations/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.PaymentMethodConfigurations.Configuration.ID) async throws(any Swift.Error) ->
                Stripe.PaymentMethodConfigurations.Configuration

        // https://docs.stripe.com/api/payment_method_configurations/update.md
        public var update:
            @Sendable (
                _ id: Stripe.PaymentMethodConfigurations.Configuration.ID, _ request: Update.Request
            ) async throws(any Swift.Error) -> Stripe.PaymentMethodConfigurations.Configuration

        // https://docs.stripe.com/api/payment_method_configurations/list.md
        public var list: @Sendable (_ request: List.Request) async throws(any Swift.Error) -> List.Response
    }
}
