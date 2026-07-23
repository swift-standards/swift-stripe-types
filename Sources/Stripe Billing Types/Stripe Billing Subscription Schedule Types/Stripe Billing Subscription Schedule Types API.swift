//
//  Stripe Billing Subscription Schedule Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Billing.Subscription.Schedule {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/subscription_schedules/create.md
        case create(request: Stripe.Billing.Subscription.Schedule.Create.Request)
        // https://docs.stripe.com/api/subscription_schedules/retrieve.md
        case retrieve(id: Stripe.Billing.Subscription.Schedule.ID)
        // https://docs.stripe.com/api/subscription_schedules/update.md
        case update(
            id: Stripe.Billing.Subscription.Schedule.ID,
            request: Stripe.Billing.Subscription.Schedule.Update.Request
        )
        // https://docs.stripe.com/api/subscription_schedules/list.md
        case list(request: Stripe.Billing.Subscription.Schedule.List.Request)
        // https://docs.stripe.com/api/subscription_schedules/cancel.md
        case cancel(
            id: Stripe.Billing.Subscription.Schedule.ID,
            request: Stripe.Billing.Subscription.Schedule.Cancel.Request
        )
        // https://docs.stripe.com/api/subscription_schedules/release.md
        case release(
            id: Stripe.Billing.Subscription.Schedule.ID,
            request: Stripe.Billing.Subscription.Schedule.Release.Request
        )
    }
}

extension Stripe.Billing.Subscription.Schedule.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Subscription.Schedule.API> {
            OneOf {
                // https://docs.stripe.com/api/subscription_schedules/create.md
                URLRouting.Route(.case(Stripe.Billing.Subscription.Schedule.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.subscription_schedules
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Subscription.Schedule.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/subscription_schedules/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Subscription.Schedule.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.subscription_schedules
                    Path {
                        Parse(.string.representing(Stripe.Billing.Subscription.Schedule.ID.self))
                    }
                }

                // https://docs.stripe.com/api/subscription_schedules/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Subscription.Schedule.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.subscription_schedules
                    Path {
                        Parse(.string.representing(Stripe.Billing.Subscription.Schedule.ID.self))
                    }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Subscription.Schedule.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/subscription_schedules/list.md
                URLRouting.Route(.case(Stripe.Billing.Subscription.Schedule.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.subscription_schedules
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0.0.0, $0.0.0.0.0.0.0.0.1, $0.0.0.0.0.0.0.1, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6), $0.7), $0.8) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Subscription.Schedule.List.Request.init,
                                { ($0.canceledAt, $0.completedAt, $0.created, $0.customer, $0.endingBefore, $0.limit, $0.releasedAt, $0.scheduled, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("canceled_at") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("completed_at") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("created") {
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
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("released_at") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("scheduled") { Bool.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/subscription_schedules/cancel.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Subscription.Schedule.API.cases.cancel))) {
                    Method.post
                    Path.v1
                    Path.subscription_schedules
                    Path {
                        Parse(.string.representing(Stripe.Billing.Subscription.Schedule.ID.self))
                    }
                    Path.cancel
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Subscription.Schedule.Cancel.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/subscription_schedules/release.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Subscription.Schedule.API.cases.release))) {
                    Method.post
                    Path.v1
                    Path.subscription_schedules
                    Path {
                        Parse(.string.representing(Stripe.Billing.Subscription.Schedule.ID.self))
                    }
                    Path.release
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Subscription.Schedule.Release.Request.self,
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
    public static var subscription_schedules: Path<PathBuilder.Component<String>> { Path {
        "subscription_schedules"
    } }

    public static var cancel: Path<PathBuilder.Component<String>> { Path {
        "cancel"
    } }

    public static var release: Path<PathBuilder.Component<String>> { Path {
        "release"
    } }
}
