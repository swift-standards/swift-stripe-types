import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Capital {
    public struct Client: Sendable {
        public var financingOffer: Stripe.Capital.FinancingOffer.Client
        public var financingSummary: Stripe.Capital.FinancingSummary.Client

        public init(
            financingOffer: Stripe.Capital.FinancingOffer.Client = .unimplemented(),
            financingSummary: Stripe.Capital.FinancingSummary.Client = .unimplemented()
        ) {
            self.financingOffer = financingOffer
            self.financingSummary = financingSummary
        }
    }
}
