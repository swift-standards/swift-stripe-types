import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Credit.Balance {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/credit-balance-transaction/retrieve.md
        public var retrieve: @Sendable (_ id: Transaction.ID) async throws(Witness.Unimplemented.Error) -> Transaction

        // https://docs.stripe.com/api/billing/credit-balance-transaction/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> Transaction.List
    }
}
