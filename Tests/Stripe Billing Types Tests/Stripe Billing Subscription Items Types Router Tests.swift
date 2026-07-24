//
//  Stripe Billing Subscription Items Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Subscription Items Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingSubscriptionItemsRouterTests {
    let router = Stripe.Billing.SubscriptionItems.API.Router()

    @Test("Create subscription item URL generation")
    func testCreateSubscriptionItem() throws {
        let request = Stripe.Billing.SubscriptionItems.Create.Request(
            subscription: "sub_123",
            price: "price_123",
            quantity: 2
        )
        let api = Stripe.Billing.SubscriptionItems.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_items")
    }

    @Test("Update subscription item URL generation")
    func testUpdateSubscriptionItem() throws {
        let request = Stripe.Billing.SubscriptionItems.Update.Request(
            quantity: 3,
            metadata: ["key": "value"]
        )
        let api = Stripe.Billing.SubscriptionItems.API.update(id: "si_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_items/si_123")
    }

    @Test("Retrieve subscription item URL generation")
    func testRetrieveSubscriptionItem() throws {
        let api = Stripe.Billing.SubscriptionItems.API.retrieve(id: "si_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_items/si_123")
    }

    @Test("List subscription items URL generation")
    func testListSubscriptionItems() throws {
        let request = Stripe.Billing.SubscriptionItems.List.Request(
            subscription: "sub_123",
            limit: 10
        )
        let api = Stripe.Billing.SubscriptionItems.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_items")
        #expect(url.query?.contains("subscription=sub_123") == true)
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Delete subscription item URL generation")
    func testDeleteSubscriptionItem() throws {
        let api = Stripe.Billing.SubscriptionItems.API.delete(id: "si_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_items/si_123")
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.SubscriptionItems.API.retrieve(id: "si_123")
        let request = try router.request(for: original)
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for delete")
    func testRoundTripDelete() throws {
        let original = Stripe.Billing.SubscriptionItems.API.delete(id: "si_123")
        let request = try router.request(for: original)
        #expect(request.httpMethod == "DELETE")
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }
}

// §A9 toolchain gate (swift-institute/Research/swift-compiler-bug-catalog.md §A9):
// institute `Tagged` materialized inside this router's deep generic parser chains
// forces its value-witness table at first parse/print; on Swift 6.3.x
// `swift_getTypeByMangledName` returns null metadata and the test runner SIGSEGVs.
// Fixed in Swift 6.4; no source fix exists (graph-package ratified pattern —
// `.disabled(if:)`, not `withKnownIssue`, because the crash kills the runner).
// Auto-retires at the 6.4 toolchain move.
#if compiler(<6.4)
private let taggedMetadataSIGSEGV = true
#else
private let taggedMetadataSIGSEGV = false
#endif
