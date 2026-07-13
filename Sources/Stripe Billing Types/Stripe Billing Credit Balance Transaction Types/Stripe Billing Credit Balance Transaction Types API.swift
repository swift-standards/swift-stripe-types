import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.Credit.Balance {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/credit-balance-transaction/retrieve.md
        case retrieve(id: Transaction.ID)
        // https://docs.stripe.com/api/billing/credit-balance-transaction/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Billing.Credit.Balance.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Credit.Balance.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.Credit.Balance.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_balance_transactions
                    Path {
                        Parse(
                            .string.representing(Stripe.Billing.Credit.Balance.Transaction.ID.self)
                        )
                    }
                }

                URLRouting.Route(.case(Stripe.Billing.Credit.Balance.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_balance_transactions
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Credit.Balance.List.Request.init,
                                { ($0.customer, $0.creditGrant, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("customer") {
                                Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                            }
                            Optionally {
                                Field("credit_grant") { Parse(.string) }
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
    package static var credit_balance_transactions: Path<PathBuilder.Component<String>> { Path { "credit_balance_transactions" } }
}
