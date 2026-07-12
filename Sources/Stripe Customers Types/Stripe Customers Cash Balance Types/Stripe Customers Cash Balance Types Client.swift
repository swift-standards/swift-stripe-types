import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers.CashBalance {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/cash_balance/retrieve.md
        public var retrieve:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID) async throws(any Swift.Error) ->
                Stripe_Types_Models.CashBalance

        // https://docs.stripe.com/api/cash_balance/update.md
        public var update:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: Update.Request)
                async throws(any Swift.Error)
                -> Stripe_Types_Models.CashBalance
    }
}
