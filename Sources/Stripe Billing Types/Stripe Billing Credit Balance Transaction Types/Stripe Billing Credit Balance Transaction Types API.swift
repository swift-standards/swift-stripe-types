import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Credit.Balance {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Billing.Credit.Balance.API.retrieve)) {
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

                URLRouting.Route(.case(Stripe.Billing.Credit.Balance.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_balance_transactions
                    Parse(.memberwise(Stripe.Billing.Credit.Balance.List.Request.init)) {
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
    package static var credit_balance_transactions: Path<PathBuilder.Component<String>> { Path { "credit_balance_transactions" } }
}
