import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Customer.Balance {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/customer_balance_transactions/create.md
        case create(customerId: Stripe.Customers.Customer.ID, request: Create.Request)
        // https://docs.stripe.com/api/customer_balance_transactions/retrieve.md
        case retrieve(customerId: Stripe.Customers.Customer.ID, id: Transaction.ID)
        // https://docs.stripe.com/api/customer_balance_transactions/update.md
        case update(
            customerId: Stripe.Customers.Customer.ID,
            id: Transaction.ID,
            request: Update.Request
        )
        // https://docs.stripe.com/api/customer_balance_transactions/list.md
        case list(customerId: Stripe.Customers.Customer.ID, request: List.Request)
    }
}

extension Stripe.Billing.Customer.Balance.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Customer.Balance.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.Customer.Balance.API.create)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.balance_transactions
                    Body(
                        .form(
                            Stripe.Billing.Customer.Balance.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Billing.Customer.Balance.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.balance_transactions
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.Customer.Balance.Transaction.ID.self
                            )
                        )
                    }
                }

                URLRouting.Route(.case(Stripe.Billing.Customer.Balance.API.update)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.balance_transactions
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.Customer.Balance.Transaction.ID.self
                            )
                        )
                    }
                    Body(
                        .form(
                            Stripe.Billing.Customer.Balance.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Billing.Customer.Balance.API.list)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.balance_transactions
                    Parse(.memberwise(Stripe.Billing.Customer.Balance.List.Request.init)) {
                        URLRouting.Query {
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
    package static var customers: Path<PathBuilder.Component<String>> { Path { "customers" } }
    package static var balance_transactions: Path<PathBuilder.Component<String>> { Path { "balance_transactions" } }
}
