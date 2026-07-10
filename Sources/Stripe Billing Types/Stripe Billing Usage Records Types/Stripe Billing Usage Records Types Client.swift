import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.UsageRecords {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/usage_records/create
        public var create:
            @Sendable (
                _ subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
                _ request: Create.Request
            ) async throws(Witness.Unimplemented.Error) -> UsageRecord

        // https://docs.stripe.com/api/usage_records/list
        public var list:
            @Sendable (
                _ subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
                _ request: List.Request
            ) async throws(Witness.Unimplemented.Error) -> List.Response
    }
}
