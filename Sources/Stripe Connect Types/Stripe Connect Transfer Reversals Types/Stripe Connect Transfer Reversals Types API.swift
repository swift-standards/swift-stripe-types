//
//  Stripe Connect Transfer Reversals Types API.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Connect.Transfer.Reversals {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/transfer_reversals/create.md
        case create(transferId: Stripe.Connect.Transfer.ID, request: Create.Request)
        // https://docs.stripe.com/api/transfer_reversals/retrieve.md
        case retrieve(
            transferId: Stripe.Connect.Transfer.ID,
            reversalId: Stripe.Connect.Transfer.Reversal.ID
        )
        // https://docs.stripe.com/api/transfer_reversals/update.md
        case update(
            transferId: Stripe.Connect.Transfer.ID,
            reversalId: Stripe.Connect.Transfer.Reversal.ID,
            request: Update.Request
        )
        // https://docs.stripe.com/api/transfer_reversals/list.md
        case list(transferId: Stripe.Connect.Transfer.ID, request: List.Request)
    }
}

extension Stripe.Connect.Transfer.Reversals.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Connect.Transfer.Reversals.API> {
            OneOf {
                Route(.convert(
                        apply: { (transferId: $0.0, request: $0.1) },
                        unapply: { ($0.transferId, $0.request) }
                    )
                    .map(.case(Stripe.Connect.Transfer.Reversals.API.cases.create))) {
                    Method.post
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    Path { "reversals" }
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Transfer.Reversals.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (transferId: $0.0, reversalId: $0.1) },
                        unapply: { ($0.transferId, $0.reversalId) }
                    )
                    .map(.case(Stripe.Connect.Transfer.Reversals.API.cases.retrieve))) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    Path { "reversals" }
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.Reversal.ID.self)) }
                }

                Route(.convert(
                        apply: { (transferId: $0.0.0, reversalId: $0.0.1, request: $0.1) },
                        unapply: { (($0.transferId, $0.reversalId), $0.request) }
                    )
                    .map(.case(Stripe.Connect.Transfer.Reversals.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    Path { "reversals" }
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.Reversal.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Transfer.Reversals.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (transferId: $0.0, request: $0.1) },
                        unapply: { ($0.transferId, $0.request) }
                    )
                    .map(.case(Stripe.Connect.Transfer.Reversals.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    Path { "reversals" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Connect.Transfer.Reversals.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
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
                        }
                    }
                }
            }
        }
    }
}
