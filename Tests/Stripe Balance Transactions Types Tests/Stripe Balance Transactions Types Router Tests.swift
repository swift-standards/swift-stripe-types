//
//  Stripe Balance Transactions Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Balance_Transactions_Types
@testable import Stripe_Types_Models

@Suite("Balance Transactions Router Tests")
struct BalanceTransactionsRouterTests {

    @Test("Creates correct URL for balance transaction retrieval")
    func testRetrieveBalanceTransactionURL() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let id = try #require(Stripe.Balance.Transaction.ID(rawValue: "txn_123"))
        let api: Stripe.BalanceTransactions.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/balance_transactions/txn_123")

        // Round-trip test
        let match: Stripe.BalanceTransactions.API = try router.match(
            request: try router.request(for: api)
        )
        #expect(match.is(\.retrieve))
        #expect(match.retrieve == id)
    }

    @Test("Creates correct URL for listing balance transactions")
    func testListBalanceTransactionsURL() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let listRequest = Stripe.BalanceTransactions.List.Request(
            payout: "po_123",
            type: "charge",
            currency: .usd,
            limit: 10
        )

        let api: Stripe.BalanceTransactions.API = .list(request: listRequest)
        let url = router.url(for: api)

        #expect(url.path == "/v1/balance_transactions")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["payout"] == "po_123")
        #expect(queryDict["type"] == "charge")
        #expect(queryDict["currency"] == "usd")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for listing with date filter")
    func testListBalanceTransactionsWithDateFilter() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let dateFilter = Stripe.DateFilter(gt: 1_609_459_200)
        let listRequest = Stripe.BalanceTransactions.List.Request(
            created: dateFilter,
            limit: 25
        )

        let api: Stripe.BalanceTransactions.API = .list(request: listRequest)
        let url = router.url(for: api)

        #expect(url.path == "/v1/balance_transactions")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] == "gt:1609459200")
        #expect(queryDict["limit"] == "25")
    }

    @Test("Creates correct URL for listing with pagination")
    func testListBalanceTransactionsWithPagination() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let listRequest = Stripe.BalanceTransactions.List.Request(
            endingBefore: "txn_456",
            limit: 50,
            startingAfter: "txn_123"
        )

        let api: Stripe.BalanceTransactions.API = .list(request: listRequest)
        let url = router.url(for: api)

        #expect(url.path == "/v1/balance_transactions")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["ending_before"] == "txn_456")
        #expect(queryDict["limit"] == "50")
        #expect(queryDict["starting_after"] == "txn_123")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveBalanceTransactionMethod() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let id = try #require(Stripe.Balance.Transaction.ID(rawValue: "txn_123"))
        let api: Stripe.BalanceTransactions.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles GET method correctly for list")
    func testListBalanceTransactionsMethod() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let listRequest = Stripe.BalanceTransactions.List.Request(limit: 10)
        let api: Stripe.BalanceTransactions.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Round-trip test for list endpoint")
    func testListRoundTrip() throws {
        let router: Stripe.BalanceTransactions.API.Router = .init()

        let listRequest = Stripe.BalanceTransactions.List.Request(
            payout: "po_test",
            type: "refund",
            limit: 5
        )

        let api: Stripe.BalanceTransactions.API = .list(request: listRequest)

        // Create request and match it back
        let match: Stripe.BalanceTransactions.API = try router.match(
            request: try router.request(for: api)
        )

        #expect(match.is(\.list))
        #expect(match.list?.payout == "po_test")
        #expect(match.list?.type == "refund")
        #expect(match.list?.limit == 5)
    }
}
