//
//  Stripe Refunds Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Refunds {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/refunds/create.md
        case create(request: Stripe.Refunds.Create.Request)
        // https://docs.stripe.com/api/refunds/retrieve.md
        case retrieve(id: Stripe.Refunds.Refund.ID)
        // https://docs.stripe.com/api/refunds/update.md
        case update(id: Stripe.Refunds.Refund.ID, request: Stripe.Refunds.Update.Request)
        // https://docs.stripe.com/api/refunds/list.md
        case list(request: Stripe.Refunds.List.Request)
        // https://docs.stripe.com/api/refunds/cancel.md
        case cancel(id: Stripe.Refunds.Refund.ID)
    }
}

extension Stripe.Refunds.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Refunds.API> {
            OneOf {
                Route(.case(Stripe.Refunds.API.create)) {
                    Method.post
                    Path.v1
                    Path.refunds
                    Body(
                        .form(
                            Stripe.Refunds.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Refunds.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.refunds
                    Path { Parse(.string.representing(Stripe.Refunds.Refund.ID.self)) }
                }

                Route(.case(Stripe.Refunds.API.update)) {
                    Method.post
                    Path.v1
                    Path.refunds
                    Path { Parse(.string.representing(Stripe.Refunds.Refund.ID.self)) }
                    Body(
                        .form(
                            Stripe.Refunds.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Refunds.API.list)) {
                    Method.get
                    Path.v1
                    Path.refunds
                    Parse(.memberwise(Stripe.Refunds.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("charge") {
                                    Parse(.string.representing(Stripe.Charges.Charge.ID.self))
                                }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("payment_intent") {
                                    Parse(
                                        .string.representing(
                                            Stripe.PaymentIntents.PaymentIntent.ID.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Refunds.API.cancel)) {
                    Method.post
                    Path.v1
                    Path.refunds
                    Path { Parse(.string.representing(Stripe.Refunds.Refund.ID.self)) }
                    Path.cancel
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var refunds: Path<PathBuilder.Component<String>> { Path {
        "refunds"
    } }
    public static var cancel: Path<PathBuilder.Component<String>> { Path {
        "cancel"
    } }
}
