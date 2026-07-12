import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Fraud.EarlyFraudWarnings {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/radar/early_fraud_warnings/retrieve.md
        public var retrieve:
            @Sendable (_ id: EarlyFraudWarning.ID) async throws(any Swift.Error) -> EarlyFraudWarning

        // https://docs.stripe.com/api/radar/early_fraud_warnings/list.md
        public var list: @Sendable (_ request: API.List.Request) async throws(any Swift.Error) -> API.List.Response
    }
}
