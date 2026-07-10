//
//  Stripe Balance Transactions Types API.swift
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

extension Stripe.BalanceTransactions {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.BalanceTransactions.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.balanceTransactions
                    Path { Parse(.string.representing(Stripe.Balance.Transaction.ID.self)) }
                }

                // https://docs.stripe.com/api/balance_transactions/list.md
                URLRouting.Route(.case(Stripe.BalanceTransactions.API.list)) {
                    Method.get
                    Path.v1
                    Path.balanceTransactions
                    Parse(.memberwise(Stripe.BalanceTransactions.List.Request.init)) {
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
                                Field("limit") { Digits() }
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
