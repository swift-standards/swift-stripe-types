//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 04/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Subscription Router Tests")
struct SubscriptionRouterTests {

    @Test("Creates correct URL for subscription creation")
    func testCreateSubscriptionURL() throws {
        let router: Stripe.Billing.Subscriptions.API.Router = .init()

        let createRequest = Stripe.Billing.Subscriptions.Create.Request(
            customer: "cus_123",
            items: [.init(price: "price_123", quantity: 2)],
            automaticTax: .init(enabled: true),
            description: "Test subscription",
            metadata: ["order_id": "12345"]
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/subscriptions")
    }

    @Test("Creates correct URL for subscription retrieval")
    func testRetrieveSubscriptionURL() throws {
        let router: Stripe.Billing.Subscriptions.API.Router = .init()

        let id = try #require(Stripe.Billing.Subscription.ID(rawValue: "sub_123"))
        let api: Stripe.Billing.Subscriptions.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/subscriptions/sub_123")

        // Round-trip test
        let match: Stripe.Billing.Subscriptions.API = try router.match(
            request: try router.request(for: api)
        )
        #expect(match.is(\.retrieve))
        #expect(match.retrieve == id)
    }

    @Test("Creates correct URL for subscription update")
    func testUpdateSubscriptionURL() throws {
        let router: Stripe.Billing.Subscriptions.API.Router = .init()

        let id = try #require(Stripe.Billing.Subscription.ID(rawValue: "sub_123"))
        let updateRequest = Stripe.Billing.Subscriptions.Update.Request(
            description: "Updated subscription",
            metadata: ["updated": "true"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/subscriptions/sub_123")
    }

    @Test("Creates correct URL for listing subscriptions")
    func testListSubscriptionsURL() throws {
        let router: Stripe.Billing.Subscriptions.API.Router = .init()

        let listRequest = Stripe.Billing.Subscriptions.List.Request(
            customer: "cus_123",
            limit: 10,
            price: "price_123",
            status: .active
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/subscriptions")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = Dictionary(
            uniqueKeysWithValues: queryItems.compactMap { item in
                item.value.map { (item.name, $0) }
            }
        )

        #expect(queryDict["customer"] == "cus_123")
        #expect(queryDict["price"] == "price_123")
        #expect(queryDict["status"] == "active")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for canceling subscription")
    func testCancelSubscriptionURL() throws {
        let router: Stripe.Billing.Subscriptions.API.Router = .init()

        let id = try #require(Stripe.Billing.Subscription.ID(rawValue: "sub_123"))
        let cancelRequest = Stripe.Billing.Subscriptions.Cancel.Request(
            invoiceNow: true,
            prorate: true
        )

        let url = router.url(for: .cancel(id: id, request: cancelRequest))
        #expect(url.path == "/v1/subscriptions/sub_123")
    }

    // TODO: Resume endpoint not available in current API
    // @Test("Creates correct URL for resuming subscription")
    // func testResumeSubscriptionURL() throws {
    //     let router: Stripe.Billing.Subscriptions.API.Router = .init()
    //
    //     let id = Stripe.Billing.Subscription.ID(rawValue: "sub_123")
    //     let resumeRequest = Stripe.Billing.Subscriptions.Update.Request(
    //         billingCycleAnchor: "now"
    //     )
    //
    //     let url = router.url(for: .resume(id: id, request: resumeRequest))
    //     #expect(url.path == "/v1/subscriptions/sub_123/resume")
    // }

    // TODO: Search endpoint not available in current API
    // @Test("Creates correct URL for searching subscriptions")
    // func testSearchSubscriptionsURL() throws {
    //     let router: Stripe.Billing.Subscriptions.API.Router = .init()
    //
    //     let searchRequest = Stripe.Billing.Subscriptions.Search.Request(
    //         query: "status:'active' AND metadata['order_id']:'12345'",
    //         limit: 10
    //     )
    //
    //     let url = router.url(for: .search(request: searchRequest))
    //     #expect(url.path == "/v1/subscriptions/search")
    //
    //     let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    //     let queryItems = components?.queryItems ?? []
    //     let queryDict = Dictionary(uniqueKeysWithValues: queryItems.compactMap { item in
    //         item.value.map { (item.name, $0) }
    //     })
    //
    //     #expect(queryDict["query"] == "status:'active' AND metadata['order_id']:'12345'")
    //     #expect(queryDict["limit"] == "10")
    // }
}
