//
//  Stripe Balance Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Balance_Types
@testable import Stripe_Types_Models

@Suite("Balance Router Tests")
struct BalanceRouterTests {

    @Test("Creates correct URL for balance retrieval")
    func testRetrieveBalanceURL() throws {
        let router: Stripe.Balance.API.Router = .init()

        let api: Stripe.Balance.API = .retrieve
        let url = router.url(for: api)

        #expect(url.path == "/v1/balance")

        // Round-trip test
        let match: Stripe.Balance.API = try router.match(request: try router.request(for: api))
        #expect(match == .retrieve)
    }

    @Test("Handles GET method correctly")
    func testRetrieveBalanceMethod() throws {
        let router: Stripe.Balance.API.Router = .init()

        let api: Stripe.Balance.API = .retrieve
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Matches balance endpoint correctly")
    func testMatchBalanceEndpoint() throws {
        let router: Stripe.Balance.API.Router = .init()

        // Create a request that should match the balance endpoint
        var request = URLRequest(url: URL(string: "/v1/balance")!)
        request.httpMethod = "GET"

        let matched = try router.match(request: request)
        #expect(matched == .retrieve)
    }
}
