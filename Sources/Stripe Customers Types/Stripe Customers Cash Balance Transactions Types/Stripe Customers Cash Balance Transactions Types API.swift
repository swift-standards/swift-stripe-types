import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Customers.CashBalanceTransactions {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/cash_balance_transactions/retrieve.md
        case retrieve(
            customerId: Stripe.Customers.Customer.ID,
            transactionId: CashBalanceTransaction.ID
        )
        // https://docs.stripe.com/api/cash_balance_transactions/list.md
        case list(customerId: Stripe.Customers.Customer.ID, request: List.Request)
    }
}

extension Stripe.Customers.CashBalanceTransactions.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.CashBalanceTransactions.API> {
            OneOf {
                Route(.case(Stripe.Customers.CashBalanceTransactions.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalanceTransactions
                    Path { Parse(.string.representing(CashBalanceTransaction.ID.self)) }
                }

                Route(.case(Stripe.Customers.CashBalanceTransactions.API.list)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalanceTransactions
                    Parse(.memberwise(Stripe.Customers.CashBalanceTransactions.List.Request.init)) {
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
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var cashBalanceTransactions: Path<PathBuilder.Component<String>> { Path {
        "cash_balance_transactions"
    } }
}
