//
//  Stripe Billing Invoices Types Router Tests.swift
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

@Suite("Billing Invoices Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingInvoicesRouterTests {
    let router = Stripe.Billing.Invoices.API.Router()

    @Test("Create invoice URL generation")
    func testCreateInvoice() throws {
        let request = Stripe.Billing.Invoices.Create.Request(
            customer: "cus_123",
            description: "Test invoice"
        )
        let api = Stripe.Billing.Invoices.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices")
    }

    @Test("Create preview invoice URL generation")
    func testCreatePreviewInvoice() throws {
        let request = Stripe.Billing.Invoices.CreatePreview.Request(
            customer: "cus_123"
        )
        let api = Stripe.Billing.Invoices.API.createPreview(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/create_preview")
    }

    @Test("Retrieve invoice URL generation")
    func testRetrieveInvoice() throws {
        let api = Stripe.Billing.Invoices.API.retrieve(id: "in_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123")
    }

    @Test("Update invoice URL generation")
    func testUpdateInvoice() throws {
        let request = Stripe.Billing.Invoices.Update.Request(
            description: "Updated description"
        )
        let api = Stripe.Billing.Invoices.API.update(id: "in_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123")
    }

    @Test("List invoices URL generation")
    func testListInvoices() throws {
        let request = Stripe.Billing.Invoices.List.Request(
            customer: "cus_123",
            limit: 10
        )
        let api = Stripe.Billing.Invoices.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices")
        #expect(url.query?.contains("customer=cus_123") == true)
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Delete invoice URL generation")
    func testDeleteInvoice() throws {
        let api = Stripe.Billing.Invoices.API.delete(id: "in_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123")
    }

    @Test("Finalize invoice URL generation")
    func testFinalizeInvoice() throws {
        let request = Stripe.Billing.Invoices.Finalize.Request(autoAdvance: true)
        let api = Stripe.Billing.Invoices.API.finalize(id: "in_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123/finalize")
    }

    @Test("Pay invoice URL generation")
    func testPayInvoice() throws {
        let request = Stripe.Billing.Invoices.Pay.Request(paymentMethod: "pm_123")
        let api = Stripe.Billing.Invoices.API.pay(id: "in_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123/pay")
    }

    @Test("Send invoice URL generation")
    func testSendInvoice() throws {
        let request = Stripe.Billing.Invoices.Send.Request()
        let api = Stripe.Billing.Invoices.API.send(id: "in_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123/send")
    }

    @Test("Void invoice URL generation")
    func testVoidInvoice() throws {
        let request = Stripe.Billing.Invoices.Void.Request()
        let api = Stripe.Billing.Invoices.API.void(id: "in_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/invoices/in_123/void")
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.Invoices.API.retrieve(id: "in_123")
        let request = try router.request(for: original)
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
