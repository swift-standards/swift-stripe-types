//
//  Stripe Billing Plans Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Plans {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/plans/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Plans.Create.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Plan

        // https://docs.stripe.com/api/plans/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Plan.ID) async throws(any Swift.Error) -> Stripe.Billing.Plan

        // https://docs.stripe.com/api/plans/update.md
        public var update:
            @Sendable (_ id: Stripe.Billing.Plan.ID, _ request: Stripe.Billing.Plans.Update.Request)
                async throws(any Swift.Error) -> Stripe.Billing.Plan

        // https://docs.stripe.com/api/plans/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Plans.List.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Plans.List.Response

        // https://docs.stripe.com/api/plans/delete.md
        public var delete:
            @Sendable (_ id: Stripe.Billing.Plan.ID) async throws(any Swift.Error) -> DeletedObject<
                Stripe.Billing.Plan
            >
    }
}
