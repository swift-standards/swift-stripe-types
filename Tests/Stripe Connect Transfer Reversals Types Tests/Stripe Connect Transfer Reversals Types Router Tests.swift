//
//  Stripe Connect Transfer Reversals Types Router Tests.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Connect_Types
@testable import Stripe_Types_Models

@Suite("Connect Transfer Reversals Router Tests")
struct ConnectTransferReversalsRouterTests {
    let router = Stripe.Connect.Transfer.Reversals.API.Router()

    @Test("Create transfer reversal")
    func testCreateTransferReversal() throws {
        let transferId = Stripe.Connect.Transfer.ID("tr_1234567890")
        let request = Stripe.Connect.Transfer.Reversals.Create.Request(
            amount: 1000,
            description: "Reversing transfer",
            metadata: ["order_id": "123"],
            refundApplicationFee: true
        )

        let api = Stripe.Connect.Transfer.Reversals.API.create(
            transferId: transferId,
            request: request
        )

        // Generate URL request
        let urlRequest = try router.request(
            for: api,
            baseURL: URL(string: "https://api.stripe.com")!
        )

        // Verify method
        #expect(urlRequest.httpMethod == "POST")

        // Verify URL
        #expect(
            urlRequest.url?.absoluteString
                == "https://api.stripe.com/v1/transfers/tr_1234567890/reversals"
        )

        // Verify body contains form data
        #expect(urlRequest.httpBody != nil)

        // Parse back the API from the request
        let parsedAPI = try router.parse(
            request: urlRequest,
            baseURL: URL(string: "https://api.stripe.com")!
        )
        #expect(parsedAPI == api)
    }

    @Test("Retrieve transfer reversal")
    func testRetrieveTransferReversal() throws {
        let transferId = Stripe.Connect.Transfer.ID("tr_test")
        let reversalId = Stripe.Connect.Transfer.Reversal.ID("trr_test")

        let api = Stripe.Connect.Transfer.Reversals.API.retrieve(
            transferId: transferId,
            reversalId: reversalId
        )

        // Generate URL request
        let urlRequest = try router.request(
            for: api,
            baseURL: URL(string: "https://api.stripe.com")!
        )

        // Verify method
        #expect(urlRequest.httpMethod == "GET")

        // Verify URL
        #expect(
            urlRequest.url?.absoluteString
                == "https://api.stripe.com/v1/transfers/tr_test/reversals/trr_test"
        )

        // Verify no body
        #expect(urlRequest.httpBody == nil)

        // Parse back the API from the request
        let parsedAPI = try router.parse(
            request: urlRequest,
            baseURL: URL(string: "https://api.stripe.com")!
        )
        #expect(parsedAPI == api)
    }

    @Test("Update transfer reversal")
    func testUpdateTransferReversal() throws {
        let transferId = Stripe.Connect.Transfer.ID("tr_update")
        let reversalId = Stripe.Connect.Transfer.Reversal.ID("trr_update")
        let request = Stripe.Connect.Transfer.Reversals.Update.Request(
            description: "Updated description",
            metadata: ["key": "value"]
        )

        let api = Stripe.Connect.Transfer.Reversals.API.update(
            transferId: transferId,
            reversalId: reversalId,
            request: request
        )

        // Generate URL request
        let urlRequest = try router.request(
            for: api,
            baseURL: URL(string: "https://api.stripe.com")!
        )

        // Verify method
        #expect(urlRequest.httpMethod == "POST")

        // Verify URL
        #expect(
            urlRequest.url?.absoluteString
                == "https://api.stripe.com/v1/transfers/tr_update/reversals/trr_update"
        )

        // Verify body contains form data
        #expect(urlRequest.httpBody != nil)
    }

    @Test("List transfer reversals")
    func testListTransferReversals() throws {
        let transferId = Stripe.Connect.Transfer.ID("tr_list")
        let request = Stripe.Connect.Transfer.Reversals.List.Request(
            endingBefore: "trr_before",
            limit: 25,
            startingAfter: "trr_after"
        )

        let api = Stripe.Connect.Transfer.Reversals.API.list(
            transferId: transferId,
            request: request
        )

        // Generate URL request
        let urlRequest = try router.request(
            for: api,
            baseURL: URL(string: "https://api.stripe.com")!
        )

        // Verify method
        #expect(urlRequest.httpMethod == "GET")

        // Verify URL with query parameters
        let components = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
        #expect(components.path == "/v1/transfers/tr_list/reversals")

        let queryItems = components.queryItems ?? []
        #expect(queryItems.contains(URLQueryItem(name: "ending_before", value: "trr_before")))
        #expect(queryItems.contains(URLQueryItem(name: "limit", value: "25")))
        #expect(queryItems.contains(URLQueryItem(name: "starting_after", value: "trr_after")))
    }

    @Test("List transfer reversals with minimal parameters")
    func testListTransferReversalsMinimal() throws {
        let transferId = Stripe.Connect.Transfer.ID("tr_minimal")
        let request = Stripe.Connect.Transfer.Reversals.List.Request()

        let api = Stripe.Connect.Transfer.Reversals.API.list(
            transferId: transferId,
            request: request
        )

        // Generate URL request
        let urlRequest = try router.request(
            for: api,
            baseURL: URL(string: "https://api.stripe.com")!
        )

        // Verify method
        #expect(urlRequest.httpMethod == "GET")

        // Verify URL
        #expect(
            urlRequest.url?.absoluteString
                == "https://api.stripe.com/v1/transfers/tr_minimal/reversals"
        )
    }
}
