import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Billing.UsageRecordSummary {
    @Cases
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
                URLRouting.Route(.convert(
                        apply: { (subscriptionItemId: $0.0, request: $0.1) },
                        unapply: { ($0.subscriptionItemId, $0.request) }
                    )
                    .map(.case(Stripe.Billing.UsageRecordSummary.API.cases.list))) {
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
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.UsageRecordSummary.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
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
