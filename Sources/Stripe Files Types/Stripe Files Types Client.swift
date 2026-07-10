//
//  Stripe Files Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Files {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/files/create.md
        public var create:
            @Sendable (_ request: Stripe.Files.Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.Files.File

        // https://docs.stripe.com/api/files/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Files.File.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Files.File

        // https://docs.stripe.com/api/files/list.md
        public var list:
            @Sendable (_ request: Stripe.Files.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Files.List.Response
    }
}
