//
//  Stripe Tokens Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Tokens {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/tokens/create.md
        public var create:
            @Sendable (_ request: Stripe.Tokens.Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.Tokens.Token

        // https://docs.stripe.com/api/tokens/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Tokens.Token.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Tokens.Token
    }
}
