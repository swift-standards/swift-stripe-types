//
//  Stripe Payouts Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Payouts {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payouts/create.md
        case create(request: Stripe.Payouts.Create.Request)
        // https://docs.stripe.com/api/payouts/retrieve.md
        case retrieve(id: Stripe.Payouts.Payout.ID)
        // https://docs.stripe.com/api/payouts/update.md
        case update(id: Stripe.Payouts.Payout.ID, request: Stripe.Payouts.Update.Request)
        // https://docs.stripe.com/api/payouts/list.md
        case list(request: Stripe.Payouts.List.Request)
        // https://docs.stripe.com/api/payouts/cancel.md
        case cancel(id: Stripe.Payouts.Payout.ID)
        // https://docs.stripe.com/api/payouts/reverse.md
        case reverse(id: Stripe.Payouts.Payout.ID, request: Stripe.Payouts.Reverse.Request)
    }
}

extension Stripe.Payouts.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Payouts.API> {
            OneOf {
                Route(.case(Stripe.Payouts.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.payouts
                    URLRouting.Body(
                        .form(
                            Stripe.Payouts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Payouts.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.payouts
                    Path { Parse(.string.representing(Stripe.Payouts.Payout.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Payouts.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.payouts
                    Path { Parse(.string.representing(Stripe.Payouts.Payout.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Payouts.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Payouts.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.payouts
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Payouts.List.Request.init,
                                { ($0.arrivalDate, $0.created, $0.destination, $0.endingBefore, $0.limit, $0.startingAfter, $0.status) }
                            )
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("arrival_date") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("destination") { Parse(.string) }
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
                            Optionally {
                                Field("status") {
                                    Parse(.string.representing(Stripe.Payouts.Payout.Status.self))
                                }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Payouts.API.cases.cancel)) {
                    Method.post
                    Path.v1
                    Path.payouts
                    Path { Parse(.string.representing(Stripe.Payouts.Payout.ID.self)) }
                    Path.cancel
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Payouts.API.cases.reverse))) {
                    Method.post
                    Path.v1
                    Path.payouts
                    Path { Parse(.string.representing(Stripe.Payouts.Payout.ID.self)) }
                    Path.reverse
                    URLRouting.Body(
                        .form(
                            Stripe.Payouts.Reverse.Request.self,
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
    public static var payouts: Path<PathBuilder.Component<String>> { Path {
        "payouts"
    } }

    public static var cancel: Path<PathBuilder.Component<String>> { Path {
        "cancel"
    } }

    public static var reverse: Path<PathBuilder.Component<String>> { Path {
        "reverse"
    } }
}
