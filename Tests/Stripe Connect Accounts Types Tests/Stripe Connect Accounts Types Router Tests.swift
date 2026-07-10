//
//  Stripe Connect Accounts Types Router Tests.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Connect_Accounts_Types
@testable import Stripe_Types_Models

@Suite("Connect Accounts Router Tests")
struct ConnectAccountsRouterTests {
    let router = Stripe.Connect.Accounts.API.Router()

    @Test("Create account route")
    func testCreateRoute() throws {
        let request = Stripe.Connect.Accounts.Create.Request(
            email: "test@example.com",
            country: "US",
            type: .express
        )

        let route = Stripe.Connect.Accounts.API.create(request: request)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "POST")
        #expect(requestData.path == "/v1/accounts")
    }

    @Test("Retrieve account route")
    func testRetrieveRoute() throws {
        let accountId = Stripe.Connect.Account.ID("acct_123")
        let route = Stripe.Connect.Accounts.API.retrieve(id: accountId)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "GET")
        #expect(requestData.path == "/v1/accounts/acct_123")
    }

    @Test("Update account route")
    func testUpdateRoute() throws {
        let accountId = Stripe.Connect.Account.ID("acct_123")
        let request = Stripe.Connect.Accounts.Update.Request(
            email: "updated@example.com"
        )
        let route = Stripe.Connect.Accounts.API.update(id: accountId, request: request)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "POST")
        #expect(requestData.path == "/v1/accounts/acct_123")
    }

    @Test("List accounts route")
    func testListRoute() throws {
        let request = Stripe.Connect.Accounts.List.Request(
            limit: 10
        )
        let route = Stripe.Connect.Accounts.API.list(request: request)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "GET")
        #expect(requestData.path == "/v1/accounts")
        #expect(requestData.query?.contains("limit=10") == true)
    }

    @Test("Delete account route")
    func testDeleteRoute() throws {
        let accountId = Stripe.Connect.Account.ID("acct_123")
        let route = Stripe.Connect.Accounts.API.delete(id: accountId)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "DELETE")
        #expect(requestData.path == "/v1/accounts/acct_123")
    }

    @Test("Reject account route")
    func testRejectRoute() throws {
        let accountId = Stripe.Connect.Account.ID("acct_123")
        let request = Stripe.Connect.Accounts.Reject.Request(reason: .fraud)
        let route = Stripe.Connect.Accounts.API.reject(id: accountId, request: request)

        let requestData = try router.request(
            for: route,
            base: URL(string: "https://api.stripe.com")!
        )

        #expect(requestData.method == "POST")
        #expect(requestData.path == "/v1/accounts/acct_123/reject")
    }

    @Test("Round-trip parsing")
    func testRoundTripParsing() throws {
        let testCases: [Stripe.Connect.Accounts.API] = [
            .retrieve(id: Stripe.Connect.Account.ID("acct_123")),
            .delete(id: Stripe.Connect.Account.ID("acct_456")),
            .list(request: Stripe.Connect.Accounts.List.Request(limit: 25)),
        ]

        for testCase in testCases {
            let requestData = try router.request(
                for: testCase,
                base: URL(string: "https://api.stripe.com")!
            )
            let parsed = try router.parse(requestData)
            #expect(parsed == testCase)
        }
    }
}
