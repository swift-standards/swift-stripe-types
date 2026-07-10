//
//  Stripe Connect Account Session Types Client.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Connect.Account.Session {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/account_sessions/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.Connect.Account.Session
    }
}
