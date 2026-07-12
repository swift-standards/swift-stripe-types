//
//  Stripe Connect Accounts Types Client.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Connect.Accounts {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/accounts/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(any Swift.Error) -> Stripe.Connect.Account

        // https://docs.stripe.com/api/accounts/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Connect.Account.ID) async throws(any Swift.Error) -> Stripe.Connect.Account

        // https://docs.stripe.com/api/accounts/update.md
        public var update:
            @Sendable (_ id: Stripe.Connect.Account.ID, _ request: Update.Request) async throws(any Swift.Error) ->
                Stripe.Connect.Account

        // https://docs.stripe.com/api/accounts/list.md
        public var list: @Sendable (_ request: List.Request) async throws(any Swift.Error) -> List.Response

        // https://docs.stripe.com/api/accounts/delete.md
        public var delete:
            @Sendable (_ id: Stripe.Connect.Account.ID) async throws(any Swift.Error) -> DeletedObject<
                Stripe.Connect.Account
            >

        // https://docs.stripe.com/api/accounts/reject.md
        public var reject:
            @Sendable (_ id: Stripe.Connect.Account.ID, _ request: Reject.Request) async throws(any Swift.Error) ->
                Stripe.Connect.Account
    }
}
