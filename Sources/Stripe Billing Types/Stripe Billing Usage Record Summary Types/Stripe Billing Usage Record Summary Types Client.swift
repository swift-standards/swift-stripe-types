import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.UsageRecordSummary {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/usage_records/subscription_item_summary_list
        public var list:
            @Sendable (
                _ subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
                _ request: List.Request
            ) async throws(any Swift.Error) -> List.Response
    }
}
