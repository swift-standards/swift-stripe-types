//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Customers {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Customers.API.create)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Body(
                        .form(
                            Stripe.Customers.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Customers.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Customers.API.update)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Body(
                        .form(
                            Stripe.Customers.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Customers.API.list)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Parse(.memberwise(Stripe.Customers.List.Request.init)) {
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
                                Field("limit") { Digits() }
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

                URLRouting.Route(.case(Stripe.Customers.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Customers.API.search)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path.search
                    Parse(.memberwise(Stripe.Customers.Search.Request.init)) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("page") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Customers.API.bankAccounts)) {
                    Stripe.Customers.BankAccounts.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cards)) {
                    Stripe.Customers.Cards.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cashBalance)) {
                    Stripe.Customers.CashBalance.API.Router()
                }

                URLRouting.Route(.case(Stripe.Customers.API.cashBalanceTransactions)) {
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
