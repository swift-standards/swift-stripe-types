import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers.CashBalanceTransactions {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/cash_balance_transactions/retrieve.md
        public var retrieve:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID,
                _ transactionId: CashBalanceTransaction.ID
            ) async throws(Witness.Unimplemented.Error) -> CashBalanceTransaction

        // https://docs.stripe.com/api/cash_balance_transactions/list.md
        public var list:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: List.Request)
                async throws(Witness.Unimplemented.Error)
                -> List.Response
    }
}
