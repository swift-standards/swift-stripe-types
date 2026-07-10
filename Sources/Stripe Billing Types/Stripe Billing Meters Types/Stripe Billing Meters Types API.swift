//
//  Stripe Billing Meters Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Meters {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.Billing.Meters.API.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Body(
                        .form(
                            Stripe.Billing.Meters.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Meters.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                }

                Route(.case(Stripe.Billing.Meters.API.update)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Meters.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Meters.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Parse(.memberwise(Stripe.Billing.Meters.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
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

                Route(.case(Stripe.Billing.Meters.API.deactivate)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    Path.deactivate
                    Body(
                        .form(
                            Stripe.Billing.Meters.Deactivate.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Meters.API.reactivate)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string.representing(Stripe.Billing.Meters.Meter.ID.self)) }
                    Path.reactivate
                    Body(
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
