import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Customer.Balance {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/customer_balance_transactions/create.md
        public var create:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: Create.Request)
                async throws(Witness.Unimplemented.Error)
                -> Transaction

        // https://docs.stripe.com/api/customer_balance_transactions/retrieve.md
        public var retrieve:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ id: Transaction.ID)
                async throws(Witness.Unimplemented.Error) ->
                Transaction

        // https://docs.stripe.com/api/customer_balance_transactions/update.md
        public var update:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID, _ id: Transaction.ID,
                _ request: Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Transaction

        // https://docs.stripe.com/api/customer_balance_transactions/list.md
        public var list:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: List.Request)
                async throws(Witness.Unimplemented.Error)
                -> Transaction.List
    }
}
