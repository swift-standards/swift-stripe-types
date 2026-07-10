import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Billing.UsageRecords {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/usage_records/create
        case create(
            subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
            request: Create.Request
        )
        // https://docs.stripe.com/api/usage_records/list
        case list(
            subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID,
            request: List.Request
        )
    }
}

extension Stripe.Billing.UsageRecords.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.UsageRecords.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.UsageRecords.API.create)) {
                    Method.post
                    Path.v1
                    Path.subscription_items
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.SubscriptionItems.SubscriptionItem.ID.self
                            )
                        )
                    }
                    Path.usage_records
                    Body(
                        .form(
                            Stripe.Billing.UsageRecords.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Billing.UsageRecords.API.list)) {
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
                    Path.usage_records
                    Parse(.memberwise(Stripe.Billing.UsageRecords.List.Request.init)) {
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
    package static var usage_records: Path<PathBuilder.Component<String>> { Path { "usage_records" } }
}
