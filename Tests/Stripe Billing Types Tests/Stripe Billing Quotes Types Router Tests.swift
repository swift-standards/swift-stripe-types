//
//  Stripe Billing Quotes Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Quotes Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingQuotesRouterTests {
    let router = Stripe.Billing.Quotes.API.Router()

    @Test("Create quote URL generation")
    func testCreateQuote() throws {
        let request = Stripe.Billing.Quotes.Create.Request(
            customer: "cus_123",
            description: "Test quote"
        )
        let api = Stripe.Billing.Quotes.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes")
    }

    @Test("Retrieve quote URL generation")
    func testRetrieveQuote() throws {
        let api = Stripe.Billing.Quotes.API.retrieve(id: "qt_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123")
    }

    @Test("Update quote URL generation")
    func testUpdateQuote() throws {
        let request = Stripe.Billing.Quotes.Update.Request(
            description: "Updated quote"
        )
        let api = Stripe.Billing.Quotes.API.update(id: "qt_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123")
    }

    @Test("List quotes URL generation")
    func testListQuotes() throws {
        let request = Stripe.Billing.Quotes.List.Request(
            customer: "cus_123",
            status: .open,
            limit: 10
        )
        let api = Stripe.Billing.Quotes.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes")
        #expect(url.query?.contains("customer=cus_123") == true)
        #expect(url.query?.contains("status=open") == true)
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Accept quote URL generation")
    func testAcceptQuote() throws {
        let request = Stripe.Billing.Quotes.Accept.Request()
        let api = Stripe.Billing.Quotes.API.accept(id: "qt_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/accept")
    }

    @Test("Cancel quote URL generation")
    func testCancelQuote() throws {
        let request = Stripe.Billing.Quotes.Cancel.Request()
        let api = Stripe.Billing.Quotes.API.cancel(id: "qt_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/cancel")
    }

    @Test("Finalize quote URL generation")
    func testFinalizeQuote() throws {
        let request = Stripe.Billing.Quotes.Finalize.Request()
        let api = Stripe.Billing.Quotes.API.finalize(id: "qt_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/finalize")
    }

    @Test("PDF quote URL generation")
    func testPDFQuote() throws {
        let api = Stripe.Billing.Quotes.API.pdf(id: "qt_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/pdf")
    }

    @Test("List line items URL generation")
    func testListLineItems() throws {
        let request = Stripe.Billing.Quotes.List.LineItems.Request(
            limit: 10
        )
        let api = Stripe.Billing.Quotes.API.listLineItems(id: "qt_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/line_items")
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("List computed upfront line items URL generation")
    func testListComputedUpfrontLineItems() throws {
        let request = Stripe.Billing.Quotes.List.ComputedUpfrontLineItems.Request(
            limit: 10
        )
        let api = Stripe.Billing.Quotes.API.listComputedUpfrontLineItems(
            id: "qt_123",
            request: request
        )
        let url = router.url(for: api)

        #expect(url.path == "/v1/quotes/qt_123/computed_upfront_line_items")
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.Quotes.API.retrieve(id: "qt_123")
        let request = try router.request(for: original)
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for accept")
    func testRoundTripAccept() throws {
        let original = Stripe.Billing.Quotes.API.accept(id: "qt_123", request: .init())
        let request = try router.request(for: original)
        #expect(request.httpMethod == "POST")
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for cancel")
    func testRoundTripCancel() throws {
        let original = Stripe.Billing.Quotes.API.cancel(id: "qt_123", request: .init())
        let request = try router.request(for: original)
        #expect(request.httpMethod == "POST")
        #expect(request.url?.path == "/v1/quotes/qt_123/cancel")
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for finalize")
    func testRoundTripFinalize() throws {
        let original = Stripe.Billing.Quotes.API.finalize(id: "qt_123", request: .init())
        let request = try router.request(for: original)
        #expect(request.httpMethod == "POST")
        #expect(request.url?.path == "/v1/quotes/qt_123/finalize")
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
