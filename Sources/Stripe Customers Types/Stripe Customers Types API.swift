//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Customers {
    @Cases
    public enum API: Equatable, Sendable {
        case create(request: Stripe.Customers.Create.Request)
        case update(id: Stripe.Customers.Customer.ID, request: Stripe.Customers.Update.Request)
        case retrieve(id: Stripe.Customers.Customer.ID)
        case list(request: Stripe.Customers.List.Request)
        case delete(id: Stripe.Customers.Customer.ID)
        case search(request: Stripe.Customers.Search.Request)
        case bankAccounts(BankAccounts.API)
        case cards(Cards.API)
        case cashBalance(CashBalance.API)
        case cashBalanceTransactions(CashBalanceTransactions.API)
    }
}

extension Stripe.Customers.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Customers.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.customers
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Customers.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Customers.List.Request.init,
                                { ($0.created, $0.email, $0.endingBefore, $0.limit, $0.startingAfter, $0.testClock) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("email") { Parse(.string) }
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
                            Optionally {
                                Field("test_clock") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.search)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path.search
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Customers.Search.Request.init,
                                { ($0.query, $0.limit, $0.page) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("page") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.bankAccounts)) {
                    Stripe.Customers.BankAccounts.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.cards)) {
                    Stripe.Customers.Cards.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.cashBalance)) {
                    Stripe.Customers.CashBalance.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cases.cashBalanceTransactions)) {
                    Stripe.Customers.CashBalanceTransactions.API.Router()
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    package static var customers: Path<PathBuilder.Component<String>> { Path { "customers" } }
    package static var search: Path<PathBuilder.Component<String>> { Path { "search" } }
}
