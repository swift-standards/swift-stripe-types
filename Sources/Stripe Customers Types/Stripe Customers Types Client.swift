//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Customers {
    public struct Client: Sendable {
        public var create:
            @Sendable (_ request: Stripe.Customers.Create.Request) async throws(any Swift.Error) -> Customer

        public var update:
            @Sendable (_ id: Customer.ID, _ request: Stripe.Customers.Update.Request) async throws(any Swift.Error)
                ->
                Customer

        public var retrieve: @Sendable (_ id: Customer.ID) async throws(any Swift.Error) -> Customer

        public var list:
            @Sendable (_ request: Stripe.Customers.List.Request) async throws(any Swift.Error) ->
                Stripe.Customers.List.Response

        public var delete: @Sendable (_ id: Customer.ID) async throws(any Swift.Error) -> DeletedObject<Customer>

        public var search:
            @Sendable (_ request: Stripe.Customers.Search.Request) async throws(any Swift.Error) ->
                Stripe.Customers.Search.Response

        public var bankAccounts: Stripe.Customers.BankAccounts.Client
        public var cards: Stripe.Customers.Cards.Client
        public var cashBalance: Stripe.Customers.CashBalance.Client
        public var cashBalanceTransactions: Stripe.Customers.CashBalanceTransactions.Client

        public init(
            create:
                @escaping @Sendable (_ request: Stripe.Customers.Create.Request) async throws(any Swift.Error) ->
                Customer,
            update:
                @escaping @Sendable (_ id: Customer.ID, _ request: Stripe.Customers.Update.Request)
                async throws(any Swift.Error) -> Customer,
            retrieve: @escaping @Sendable (_ id: Customer.ID) async throws(any Swift.Error) -> Customer,
            list:
                @escaping @Sendable (_ request: Stripe.Customers.List.Request) async throws(any Swift.Error) ->
                Stripe.Customers.List.Response,
            delete: @escaping @Sendable (_ id: Customer.ID) async throws(any Swift.Error) -> DeletedObject<Customer>,
            search:
                @escaping @Sendable (_ request: Stripe.Customers.Search.Request) async throws(any Swift.Error) ->
                Stripe.Customers.Search.Response,
            bankAccounts: Stripe.Customers.BankAccounts.Client,
            cards: Stripe.Customers.Cards.Client,
            cashBalance: Stripe.Customers.CashBalance.Client,
            cashBalanceTransactions: Stripe.Customers.CashBalanceTransactions.Client
        ) {
            self.create = create
            self.update = update
            self.retrieve = retrieve
            self.list = list
            self.delete = delete
            self.search = search
            self.bankAccounts = bankAccounts
            self.cards = cards
            self.cashBalance = cashBalance
            self.cashBalanceTransactions = cashBalanceTransactions
        }
    }
}
