import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Customers.BankAccounts {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/customer_bank_accounts/create.md
        case create(customerId: Stripe.Customers.Customer.ID, request: Create.Request)
        // https://docs.stripe.com/api/customer_bank_accounts/retrieve.md
        case retrieve(customerId: Stripe.Customers.Customer.ID, bankAccountId: BankAccount.ID)
        // https://docs.stripe.com/api/customer_bank_accounts/update.md
        case update(
            customerId: Stripe.Customers.Customer.ID,
            bankAccountId: BankAccount.ID,
            request: Update.Request
        )
        // https://docs.stripe.com/api/customer_bank_accounts/list.md
        case list(customerId: Stripe.Customers.Customer.ID, request: List.Request)
        // https://docs.stripe.com/api/customer_bank_accounts/delete.md
        case delete(customerId: Stripe.Customers.Customer.ID, bankAccountId: BankAccount.ID)
        // https://docs.stripe.com/api/customer_bank_accounts/verify.md
        case verify(
            customerId: Stripe.Customers.Customer.ID,
            bankAccountId: BankAccount.ID,
            request: Verify.Request
        )
    }
}

extension Stripe.Customers.BankAccounts.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.BankAccounts.API> {
            OneOf {
                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.create))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.BankAccounts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (customerId: $0.0, bankAccountId: $0.1) },
                        unapply: { ($0.customerId, $0.bankAccountId) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.retrieve))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.bankAccounts
                    Path { Parse(.string.representing(BankAccount.ID.self)) }
                }

                Route(.convert(
                        apply: { (customerId: $0.0.0, bankAccountId: $0.0.1, request: $0.1) },
                        unapply: { (($0.customerId, $0.bankAccountId), $0.request) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(BankAccount.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.BankAccounts.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.bankAccounts
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Customers.BankAccounts.List.Request.init,
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

                Route(.convert(
                        apply: { (customerId: $0.0, bankAccountId: $0.1) },
                        unapply: { ($0.customerId, $0.bankAccountId) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.delete))) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(BankAccount.ID.self)) }
                }

                Route(.convert(
                        apply: { (customerId: $0.0.0, bankAccountId: $0.0.1, request: $0.1) },
                        unapply: { (($0.customerId, $0.bankAccountId), $0.request) }
                    )
                    .map(.case(Stripe.Customers.BankAccounts.API.cases.verify))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(BankAccount.ID.self)) }
                    Path.verify
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.BankAccounts.Verify.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var bankAccounts: Path<PathBuilder.Component<String>> { Path {
        "bank_accounts"
    } }

    public static var sources: Path<PathBuilder.Component<String>> { Path {
        "sources"
    } }

    public static var verify: Path<PathBuilder.Component<String>> { Path {
        "verify"
    } }
}
