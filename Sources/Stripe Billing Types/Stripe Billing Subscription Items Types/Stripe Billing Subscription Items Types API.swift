//
//  Stripe Billing Subscription Items Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.SubscriptionItems {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/subscription_items/create.md
        case create(request: Stripe.Billing.SubscriptionItems.Create.Request)
        // https://docs.stripe.com/api/subscription_items/update.md
        case update(
            id: Stripe.Billing.Subscription.Item.ID,
            request: Stripe.Billing.SubscriptionItems.Update.Request
        )
        // https://docs.stripe.com/api/subscription_items/retrieve.md
        case retrieve(id: Stripe.Billing.Subscription.Item.ID)
        // https://docs.stripe.com/api/subscription_items/list.md
        case list(request: Stripe.Billing.SubscriptionItems.List.Request)
        // https://docs.stripe.com/api/subscription_items/delete.md
        case delete(id: Stripe.Billing.Subscription.Item.ID)
    }
}

extension Stripe.Billing.SubscriptionItems.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.SubscriptionItems.API> {
            OneOf {
                // https://docs.stripe.com/api/subscription_items/create.md
                URLRouting.Route(.case(Stripe.Billing.SubscriptionItems.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.subscription_items
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.SubscriptionItems.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/subscription_items/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.SubscriptionItems.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.subscription_items
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.Item.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.SubscriptionItems.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/subscription_items/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.SubscriptionItems.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.subscription_items
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.Item.ID.self)) }
                }

                // https://docs.stripe.com/api/subscription_items/list.md
                URLRouting.Route(.case(Stripe.Billing.SubscriptionItems.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.subscription_items
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((($0.0, $0.1), $0.2), $0.3) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.SubscriptionItems.List.Request.init,
                                { ($0.subscription, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("subscription") {
                                Parse(.string.representing(Stripe.Billing.Subscription.ID.self))
                            }
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

                // https://docs.stripe.com/api/subscription_items/delete.md
                URLRouting.Route(.case(Stripe.Billing.SubscriptionItems.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.subscription_items
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.Item.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var subscription_items: Path<PathBuilder.Component<String>> { Path {
        "subscription_items"
    } }
}
