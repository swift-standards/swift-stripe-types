import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Credit.Grant {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/credit-grant/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(any Swift.Error) -> Stripe.Billing.Credit.Grant

        // https://docs.stripe.com/api/billing/credit-grant/retrieve.md
        public var retrieve: @Sendable (_ id: ID) async throws(any Swift.Error) -> Stripe.Billing.Credit.Grant

        // https://docs.stripe.com/api/billing/credit-grant/update.md
        public var update:
            @Sendable (_ id: ID, _ request: Update.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Credit.Grant

        // https://docs.stripe.com/api/billing/credit-grant/list.md
        public var list: @Sendable (_ request: List.Request) async throws(any Swift.Error) -> List.Response

        // https://docs.stripe.com/api/billing/credit-grant/expire.md
        public var expire:
            @Sendable (_ id: ID, _ request: Expire.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Credit.Grant

        // https://docs.stripe.com/api/billing/credit-grant/void.md
        public var void:
            @Sendable (_ id: ID, _ request: Void.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Credit.Grant
    }
}
