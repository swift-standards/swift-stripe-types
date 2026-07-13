//
//  Stripe Balance Transactions Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.BalanceTransactions {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/balance_transactions/retrieve.md
        case retrieve(id: Stripe.Balance.Transaction.ID)
        // https://docs.stripe.com/api/balance_transactions/list.md
        case list(request: Stripe.BalanceTransactions.List.Request)
    }
}

extension Stripe.BalanceTransactions.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.BalanceTransactions.API> {
            OneOf {
                // https://docs.stripe.com/api/balance_transactions/retrieve.md
                URLRouting.Route(.case(Stripe.BalanceTransactions.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.balanceTransactions
                    Path { Parse(.string.representing(Stripe.Balance.Transaction.ID.self)) }
                }

                // https://docs.stripe.com/api/balance_transactions/list.md
                URLRouting.Route(.case(Stripe.BalanceTransactions.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.balanceTransactions
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.BalanceTransactions.List.Request.init,
                                { ($0.payout, $0.type, $0.created, $0.currency, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("payout") {
                                    Parse(.string.representing(Stripe.Payouts.Payout.ID.self))
                                }
                            }
                            Optionally {
                                Field("type") { Parse(.string) }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("currency") {
                                    Parse(.string.representing(Stripe.Currency.self))
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
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var balanceTransactions: Path<PathBuilder.Component<String>> { Path {
        "balance_transactions"
    } }
}
