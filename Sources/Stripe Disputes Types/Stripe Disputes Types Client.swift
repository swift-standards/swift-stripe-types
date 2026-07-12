//
//  Stripe Disputes Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Disputes {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/disputes/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Disputes.Dispute.ID) async throws(any Swift.Error) -> Stripe.Disputes.Dispute

        // https://docs.stripe.com/api/disputes/update.md
        public var update:
            @Sendable (_ id: Stripe.Disputes.Dispute.ID, _ request: Stripe.Disputes.Update.Request)
                async throws(any Swift.Error) -> Stripe.Disputes.Dispute

        // https://docs.stripe.com/api/disputes/list.md
        public var list:
            @Sendable (_ request: Stripe.Disputes.List.Request) async throws(any Swift.Error) ->
                Stripe.Disputes.List.Response

        // https://docs.stripe.com/api/disputes/close.md
        public var close:
            @Sendable (_ id: Stripe.Disputes.Dispute.ID) async throws(any Swift.Error) -> Stripe.Disputes.Dispute
    }
}
