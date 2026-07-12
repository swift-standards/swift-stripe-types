//
//  Stripe Balance Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Balance {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/balance/retrieve.md
        public var retrieve: @Sendable () async throws(any Swift.Error) -> Stripe.Balance
    }
}
