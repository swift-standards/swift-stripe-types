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
import URL_Routing_Foundation_Integration

@testable import Stripe_Payment_Intents_Types
@testable import Stripe_Types_Models

@Suite("Payment Intents Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct PaymentIntentsRouterTests {

    @Test("Creates correct URL for payment intent creation")
    func testCreatePaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let createRequest = Stripe.PaymentIntents.Create.Request(
            amount: 2000,
            currency: .usd,
            automaticPaymentMethods: nil,
            confirm: true,
            customer: "cus_123",
            description: "Test payment",
            metadata: ["order_id": "12345"],
            paymentMethod: "pm_123",
            receiptEmail: "test@example.com"
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/payment_intents")
    }

    @Test("Creates correct URL for payment intent retrieval")
    func testRetrievePaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let api: Stripe.PaymentIntents.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_intents/pi_123")

        // Round-trip test
        let match: Stripe.PaymentIntents.API = try router.match(
            request: try router.request(for: api)
        )
        #expect(match.is(\.retrieve))
        #expect(Stripe.PaymentIntents.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for payment intent update")
    func testUpdatePaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let updateRequest = Stripe.PaymentIntents.Update.Request(
            amount: 3000,
            metadata: ["updated": "true"],
            receiptEmail: "updated@example.com"
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/payment_intents/pi_123")
    }

    @Test("Creates correct URL for listing payment intents")
    func testListPaymentIntentsURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let listRequest = Stripe.PaymentIntents.List.Request(
            customer: "cus_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/payment_intents")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["customer"] == "cus_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for canceling payment intent")
    func testCancelPaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let cancelRequest = Stripe.PaymentIntents.Cancel.Request(
            cancellationReason: .abandoned
        )
        let api: Stripe.PaymentIntents.API = .cancel(id: id, request: cancelRequest)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_intents/pi_123/cancel")

        // Round-trip test
        let match: Stripe.PaymentIntents.API = try router.match(
            request: try router.request(for: api)
        )
        #expect(match.is(\.cancel))
        #expect(Stripe.PaymentIntents.API.cases.cancel.extract(match)?.id == id)
        #expect(Stripe.PaymentIntents.API.cases.cancel.extract(match)?.request.cancellationReason == .abandoned)
    }

    @Test("Creates correct URL for capturing payment intent")
    func testCapturePaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let captureRequest = Stripe.PaymentIntents.Capture.Request(
            amountToCapture: 1500
        )

        let url = router.url(for: .capture(id: id, request: captureRequest))
        #expect(url.path == "/v1/payment_intents/pi_123/capture")
    }

    @Test("Creates correct URL for confirming payment intent")
    func testConfirmPaymentIntentURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let confirmRequest = Stripe.PaymentIntents.Confirm.Request(
            paymentMethod: "pm_123",
            returnUrl: "https://example.com/return"
        )

        let url = router.url(for: .confirm(id: id, request: confirmRequest))
        #expect(url.path == "/v1/payment_intents/pi_123/confirm")
    }

    @Test("Creates correct URL for incrementing authorization")
    func testIncrementAuthorizationURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let request = Stripe.PaymentIntents.IncrementAuthorization.Request(
            amount: 500,
            description: "Additional charge"
        )

        let url = router.url(for: .incrementAuthorization(id: id, request: request))
        #expect(url.path == "/v1/payment_intents/pi_123/increment_authorization")
    }

    @Test("Creates correct URL for applying customer balance")
    func testApplyCustomerBalanceURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let api: Stripe.PaymentIntents.API = .applyCustomerBalance(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_intents/pi_123/apply_customer_balance")

        // Round-trip test
        let match: Stripe.PaymentIntents.API = try router.match(
            request: try router.request(for: api)
        )
        #expect(match.is(\.applyCustomerBalance))
        #expect(Stripe.PaymentIntents.API.cases.applyCustomerBalance.extract(match) == id)
    }

    @Test("Creates correct URL for searching payment intents")
    func testSearchPaymentIntentsURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let searchRequest = Stripe.PaymentIntents.Search.Request(
            query: "status:'succeeded' AND metadata['order_id']:'12345'",
            limit: 10
        )

        let url = router.url(for: .search(request: searchRequest))
        #expect(url.path == "/v1/payment_intents/search")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["query"] == "status:'succeeded' AND metadata['order_id']:'12345'")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for verifying microdeposits")
    func testVerifyMicrodepositsURL() throws {
        let router: Stripe.PaymentIntents.API.Router = .init()

        let id = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let request = Stripe.PaymentIntents.VerifyMicrodeposits.Request(
            amounts: [32, 45]
        )

        let url = router.url(for: .verifyMicrodeposits(id: id, request: request))
        #expect(url.path == "/v1/payment_intents/pi_123/verify_microdeposits")
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
