import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.PaymentLinks {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/payment-link/create.md
        public var create:
            @Sendable (_ request: Stripe.PaymentLinks.Create.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentLink

        // https://docs.stripe.com/api/payment-link/update.md
        public var update:
            @Sendable (_ id: Stripe.PaymentLink.ID, _ request: Stripe.PaymentLinks.Update.Request)
                async throws(Witness.Unimplemented.Error) -> Stripe.PaymentLink

        // https://docs.stripe.com/api/payment-link/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.PaymentLink.ID) async throws(Witness.Unimplemented.Error) -> Stripe.PaymentLink

        // https://docs.stripe.com/api/payment-link/list.md
        public var list:
            @Sendable (_ request: Stripe.PaymentLinks.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentLinks.List.Response

        // https://docs.stripe.com/api/payment-link/retrieve-line-items.md
        public var lineItems:
            @Sendable (
                _ id: Stripe.PaymentLink.ID, _ request: Stripe.PaymentLinks.LineItems.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.PaymentLinks.LineItems.Response
    }
}
