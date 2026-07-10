import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.PaymentMethodDomains {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/payment_method_domains/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe.PaymentMethodDomain

        // https://docs.stripe.com/api/payment_method_domains/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.PaymentMethodDomain.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentMethodDomain

        // https://docs.stripe.com/api/payment_method_domains/update.md
        public var update:
            @Sendable (_ id: Stripe.PaymentMethodDomain.ID, _ request: Update.Request) async throws(Witness.Unimplemented.Error)
                ->
                Stripe.PaymentMethodDomain

        // https://docs.stripe.com/api/payment_method_domains/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response

        // https://docs.stripe.com/api/payment_method_domains/validate.md
        public var validate:
            @Sendable (_ id: Stripe.PaymentMethodDomain.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentMethodDomain
    }
}

extension Stripe.PaymentMethodDomains.Client {
    public func list() async throws -> Stripe.PaymentMethodDomains.List.Response {
        try await self.list(.init())
    }
}
