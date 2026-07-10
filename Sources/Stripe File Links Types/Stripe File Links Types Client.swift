//
//  Stripe File Links Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.FileLinks {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/file_links/create.md
        public var create:
            @Sendable (_ request: Stripe.FileLinks.Create.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.FileLinks.FileLink

        // https://docs.stripe.com/api/file_links/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.FileLinks.FileLink.ID) async throws(Witness.Unimplemented.Error) -> Stripe.FileLinks.FileLink

        // https://docs.stripe.com/api/file_links/update.md
        public var update:
            @Sendable (
                _ id: Stripe.FileLinks.FileLink.ID, _ request: Stripe.FileLinks.Update.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.FileLinks.FileLink

        // https://docs.stripe.com/api/file_links/list.md
        public var list:
            @Sendable (_ request: Stripe.FileLinks.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.FileLinks.List.Response
    }
}
