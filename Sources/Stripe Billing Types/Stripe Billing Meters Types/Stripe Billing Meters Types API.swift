//
//  Stripe Billing Meters Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.Meters {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/meter/create.md
        case create(request: Create.Request)

        // https://docs.stripe.com/api/billing/meter/retrieve.md
        case retrieve(id: Stripe.Billing.Meters.Meter.ID)

        // https://docs.stripe.com/api/billing/meter/update.md
        case update(id: Stripe.Billing.Meters.Meter.ID, request: Update.Request)

        // https://docs.stripe.com/api/billing/meter/list.md
        case list(request: List.Request)

        // https://docs.stripe.com/api/billing/meter/deactivate.md
        case deactivate(id: Stripe.Billing.Meters.Meter.ID, request: Deactivate.Request)

        // https://docs.stripe.com/api/billing/meter/reactivate.md
        case reactivate(id: Stripe.Billing.Meters.Meter.ID, request: Reactivate.Request)
    }
}

extension Stripe.Billing.Meters.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Meters.API> {
            OneOf {
                Route(.case(Stripe.Billing.Meters.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Meters.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Meters.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Meters.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Meters.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Meters.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((($0.0, $0.1), $0.2), $0.3) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Meters.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter, $0.status) }
                            )
                        )
                    ) {
                        Query {
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
                                    Parse(.string.representing(Stripe.Billing.Meters.Status.self))
                                }
                            }
                        }
                    }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Meters.API.cases.deactivate))) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    Path.deactivate
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Meters.Deactivate.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Meters.API.cases.reactivate))) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    Path.reactivate
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Meters.Reactivate.Request.self,
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
    public static var billing: Path<PathBuilder.Component<String>> { Path {
        "billing"
    } }

    public static var meters: Path<PathBuilder.Component<String>> { Path {
        "meters"
    } }

    public static var deactivate: Path<PathBuilder.Component<String>> { Path {
        "deactivate"
    } }

    public static var reactivate: Path<PathBuilder.Component<String>> { Path {
        "reactivate"
    } }
}
