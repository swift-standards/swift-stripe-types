import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.CreditBalanceSummary {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/credit-balance-summary/retrieve.md
        public var retrieve:
            @Sendable (_ request: Retrieve.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Credit.Balance.Summary
    }
}
