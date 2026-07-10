import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.PaymentMethods.PaymentMethods {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/payment_methods/create.md
        public var create:
            @Sendable (_ request: Stripe.PaymentMethods.PaymentMethods.Create.Request) async throws(Witness.Unimplemented.Error)
                ->
                Stripe.PaymentMethods.PaymentMethod

        // https://docs.stripe.com/api/payment_methods/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.PaymentMethods.PaymentMethod.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentMethods.PaymentMethod

        // https://docs.stripe.com/api/payment_methods/retrieve_customer.md
        public var retrieveCustomer:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID,
                _ paymentMethodId: Stripe.PaymentMethods.PaymentMethod.ID
            ) async throws(Witness.Unimplemented.Error) -> Stripe.PaymentMethods.PaymentMethod

        // https://docs.stripe.com/api/payment_methods/update.md
        public var update:
            @Sendable (
                _ id: Stripe.PaymentMethods.PaymentMethod.ID,
                _ request: Stripe.PaymentMethods.PaymentMethods.Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.PaymentMethods.PaymentMethod

        // https://docs.stripe.com/api/payment_methods/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response

        // https://docs.stripe.com/api/payment_methods/customer_list.md
        public var listCustomer:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID,
                _ request: Stripe.PaymentMethods.PaymentMethods.List.Customer.Request
            ) async throws(Witness.Unimplemented.Error) -> List.Customer.Response

        // https://docs.stripe.com/api/payment_methods/attach.md
        public var attach:
            @Sendable (
                _ id: Stripe.PaymentMethods.PaymentMethod.ID,
                _ request: Stripe.PaymentMethods.PaymentMethods.Attach.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.PaymentMethods.PaymentMethod

        // https://docs.stripe.com/api/payment_methods/detach.md
        public var detach:
            @Sendable (_ id: Stripe.PaymentMethods.PaymentMethod.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.PaymentMethods.PaymentMethod
    }
}
