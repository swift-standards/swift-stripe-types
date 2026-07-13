//
//  Stripe Disputes Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.Disputes {
    @Cases
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
                URLRouting.Route(.case(Stripe.Disputes.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.disputes
                    Path { Parse(.string.representing(Stripe.Disputes.Dispute.ID.self)) }
                }

                // https://docs.stripe.com/api/disputes/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Disputes.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.disputes
                    Path { Parse(.string.representing(Stripe.Disputes.Dispute.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Disputes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/disputes/list.md
                URLRouting.Route(.case(Stripe.Disputes.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.disputes
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Disputes.List.Request.init,
                                { ($0.charge, $0.paymentIntent, $0.created, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
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
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/disputes/close.md
                URLRouting.Route(.case(Stripe.Disputes.API.cases.close)) {
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
