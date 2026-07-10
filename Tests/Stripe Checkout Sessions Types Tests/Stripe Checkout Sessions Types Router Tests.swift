//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 07/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Checkout_Sessions_Types
@testable import Stripe_Types_Models

@Suite("Checkout Session Router Tests")
struct CheckoutSessionRouterTests {

    @Test("Creates correct URL for session creation")
    func testCreateSessionURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let createRequest = Stripe.Checkout.Sessions.Create.Request(
            successUrl: "https://example.com/success",
            cancelUrl: "https://example.com/cancel",
            clientReferenceId: "test_ref",
            lineItems: [
                .init(price: "price_123", quantity: 1)
            ],
            mode: .payment
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/checkout/sessions")
    }

    @Test("Creates correct URL for session retrieval")
    func testRetrieveSessionURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let id = try #require(Stripe.Checkout.Session.ID(rawValue: "cs_123"))
        let url = router.url(for: .retrieve(id: id))
        #expect(url.path == "/v1/checkout/sessions/cs_123")
    }

    @Test("Creates correct URL for session update")
    func testUpdateSessionURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let id = try #require(Stripe.Checkout.Session.ID(rawValue: "cs_123"))
        let updateRequest = Stripe.Checkout.Sessions.Update.Request(
            metadata: ["updated": "true"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/checkout/sessions/cs_123")
    }

    @Test("Creates correct URL for listing sessions")
    func testListSessionsURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let listRequest = Stripe.Checkout.Sessions.List.Request(
            paymentIntent: "pi_123",
            subscription: "sub_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/checkout/sessions")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["payment_intent"] == "pi_123")
        #expect(queryDict["subscription"] == "sub_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for expiring session")
    func testExpireSessionURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let id = try #require(Stripe.Checkout.Session.ID(rawValue: "cs_123"))
        let url = router.url(for: .expire(id: id))
        #expect(url.path == "/v1/checkout/sessions/cs_123/expire")
    }

    @Test("Creates correct URL for retrieving session line items")
    func testLineItemsSessionURL() throws {
        let router: Stripe.Checkout.Sessions.API.Router = .init()

        let id = try #require(Stripe.Checkout.Session.ID(rawValue: "cs_123"))
        let lineItemsRequest = Stripe.Checkout.Sessions.LineItems.Request(
            limit: 10
        )

        let url = router.url(for: .lineItems(id: id, request: lineItemsRequest))
        #expect(url.path == "/v1/checkout/sessions/cs_123/line_items")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["limit"] == "10")
    }
}
