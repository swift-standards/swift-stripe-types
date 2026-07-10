//
//  Stripe Events Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Events {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/events/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Events.Event.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Events.Event

        // https://docs.stripe.com/api/events/list.md
        public var list:
            @Sendable (_ request: Stripe.Events.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Events.List.Response
    }
}
