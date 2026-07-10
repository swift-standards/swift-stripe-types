import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Capital.FinancingSummary {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/capital/financing_summary/retrieve.md
        public var retrieve: @Sendable () async throws(Witness.Unimplemented.Error) -> Stripe.Capital.FinancingSummary
    }
}
