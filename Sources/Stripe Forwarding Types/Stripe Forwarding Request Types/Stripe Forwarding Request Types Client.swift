import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Forwarding.Request {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/forwarding/request/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.Forwarding.Request

        // https://docs.stripe.com/api/forwarding/request/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Forwarding.Request.ID) async throws(Witness.Unimplemented.Error) -> Stripe.Forwarding.Request

        // https://docs.stripe.com/api/forwarding/request/list.md
        public var list:
            @Sendable (_ request: Stripe.Forwarding.Request.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Forwarding.Request.List.Response
    }
}
