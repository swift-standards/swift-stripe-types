//
//  Stripe Disputes Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Disputes {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/disputes/retrieve.md
        case retrieve(id: Stripe.Disputes.Dispute.ID)
        // https://docs.stripe.com/api/disputes/update.md
        case update(id: Stripe.Disputes.Dispute.ID, request: Stripe.Disputes.Update.Request)
        // https://docs.stripe.com/api/disputes/list.md
        case list(request: Stripe.Disputes.List.Request)
        // https://docs.stripe.com/api/disputes/close.md
        case close(id: Stripe.Disputes.Dispute.ID)
    }
}

extension Stripe.Disputes.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Disputes.API> {
            OneOf {
                // https://docs.stripe.com/api/disputes/retrieve.md
                URLRouting.Route(.case(Stripe.Disputes.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.disputes
                    Path { Parse(.string.representing(Stripe.Disputes.Dispute.ID.self)) }
                }

                // https://docs.stripe.com/api/disputes/update.md
                URLRouting.Route(.case(Stripe.Disputes.API.update)) {
                    Method.post
                    Path.v1
                    Path.disputes
                    Path { Parse(.string.representing(Stripe.Disputes.Dispute.ID.self)) }
                    Body(
                        .form(
                            Stripe.Disputes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/disputes/list.md
                URLRouting.Route(.case(Stripe.Disputes.API.list)) {
                    Method.get
                    Path.v1
                    Path.disputes
                    Parse(.memberwise(Stripe.Disputes.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("charge") {
                                    Parse(.string.representing(Stripe.Charges.Charge.ID.self))
                                }
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
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/disputes/close.md
                URLRouting.Route(.case(Stripe.Disputes.API.close)) {
                    Method.post
                    Path.v1
                    Path.disputes
                    Path { Parse(.string.representing(Stripe.Disputes.Dispute.ID.self)) }
                    Path { "close" }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var disputes: Path<PathBuilder.Component<String>> { Path {
        "disputes"
    } }
}
