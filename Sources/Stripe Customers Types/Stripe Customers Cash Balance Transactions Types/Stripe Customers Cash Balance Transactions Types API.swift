import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.Customers.CashBalanceTransactions {
    @Cases
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
                Route(.convert(
                        apply: { (customerId: $0.0, transactionId: $0.1) },
                        unapply: { ($0.customerId, $0.transactionId) }
                    )
                    .map(.case(Stripe.Customers.CashBalanceTransactions.API.cases.retrieve))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalanceTransactions
                    Path { Parse(.string.representing(CashBalanceTransaction.ID.self)) }
                }

                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.CashBalanceTransactions.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalanceTransactions
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Customers.CashBalanceTransactions.List.Request.init,
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

extension Path<PathBuilder.Component<String>> {
    public static var cashBalanceTransactions: Path<PathBuilder.Component<String>> { Path {
        "cash_balance_transactions"
    } }
}
