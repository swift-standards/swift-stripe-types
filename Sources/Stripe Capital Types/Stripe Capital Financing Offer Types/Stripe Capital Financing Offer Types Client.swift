import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Capital.FinancingOffer {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/capital/financing_offers/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Capital.FinancingOffer.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.Capital.FinancingOffer

        // https://docs.stripe.com/api/capital/financing_offers/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response

        // https://docs.stripe.com/api/capital/financing_offers/mark_delivered.md
        public var markDelivered:
            @Sendable (_ id: Stripe.Capital.FinancingOffer.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.Capital.FinancingOffer
    }
}
