import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Billing.UsageRecordSummary {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/usage_records/subscription_item_summary_list
        case list(
            subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
            request: List.Request
        )
    }
}

extension Stripe.Billing.UsageRecordSummary.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.UsageRecordSummary.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.UsageRecordSummary.API.list)) {
                    Method.get
                    Path.v1
                    Path.subscription_items
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.SubscriptionItems.SubscriptionItem.ID.self
                            )
                        )
                    }
                    Path.usage_record_summaries
                    Parse(.memberwise(Stripe.Billing.UsageRecordSummary.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    package static var usage_record_summaries: Path<PathBuilder.Component<String>> { Path { "usage_record_summaries" } }
}
