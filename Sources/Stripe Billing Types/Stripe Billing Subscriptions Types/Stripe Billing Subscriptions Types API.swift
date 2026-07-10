//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Subscriptions {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/subscriptions/create.md
        case create(request: Stripe.Billing.Subscriptions.Create.Request)
        // https://docs.stripe.com/api/subscriptions/update.md
        case update(
            id: Stripe.Billing.Subscription.ID,
            request: Stripe.Billing.Subscriptions.Update.Request
        )
        // https://docs.stripe.com/api/subscriptions/retrieve.md
        case retrieve(id: Stripe.Billing.Subscription.ID)
        // https://docs.stripe.com/api/subscriptions/list.md
        case list(request: Stripe.Billing.Subscriptions.List.Request)
        // https://docs.stripe.com/api/subscriptions/cancel.md
        case cancel(
            id: Stripe.Billing.Subscription.ID,
            request: Stripe.Billing.Subscriptions.Cancel.Request
        )
    }
}

extension Stripe.Billing.Subscriptions.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Subscriptions.API> {
            OneOf {
                // https://docs.stripe.com/api/subscriptions/create.md
                URLRouting.Route(.case(Stripe.Billing.Subscriptions.API.create)) {
                    Method.post
                    Path.v1
                    Path.subscriptions
                    Body(
                        .form(
                            Stripe.Billing.Subscriptions.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
                // https://docs.stripe.com/api/subscriptions/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Subscriptions.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.subscriptions
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.ID.self)) }
                }
                // https://docs.stripe.com/api/subscriptions/update.md
                URLRouting.Route(.case(Stripe.Billing.Subscriptions.API.update)) {
                    Method.post
                    Path.v1
                    Path.subscriptions
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Subscriptions.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
                // https://docs.stripe.com/api/subscriptions/list.md
                URLRouting.Route(.case(Stripe.Billing.Subscriptions.API.list)) {
                    Method.get
                    Path.v1
                    Path.subscriptions
                    Parse(.memberwise(Stripe.Billing.Subscriptions.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("automatic_tax") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("collection_method") {
                                    Parse(
                                        .string.representing(
                                            Stripe.Billing.Subscription.Collection.Method.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("current_period_end") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("current_period_start") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("price") {
                                    Parse(.string.representing(Stripe.Products.Price.ID.self))
                                }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("status") {
                                    Parse(
                                        .string.representing(
                                            Stripe.Billing.Subscription.Status.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("test_clock") { Parse(.string) }
                            }
                        }
                    }
                }
                // https://docs.stripe.com/api/subscriptions/cancel.md
                URLRouting.Route(.case(Stripe.Billing.Subscriptions.API.cancel)) {
                    Method.delete
                    Path.v1
                    Path.subscriptions
                    Path { Parse(.string.representing(Stripe.Billing.Subscription.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Subscriptions.Cancel.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    package static var subscriptions: Path<PathBuilder.Component<String>> { Path { "subscriptions" } }
}
