//
//  Stripe Billing Credit Notes Types Router Tests.swift
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

@Suite("Billing Credit Notes Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingCreditNotesRouterTests {
    let router = Stripe.Billing.CreditNotes.API.Router()

    @Test("Create credit note URL generation")
    func testCreateCreditNote() throws {
        let request = Stripe.Billing.CreditNotes.Create.Request(
            invoice: "in_123",
            amount: 1000,
            memo: "Test credit note"
        )
        let api = Stripe.Billing.CreditNotes.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes")
    }

    @Test("Update credit note URL generation")
    func testUpdateCreditNote() throws {
        let request = Stripe.Billing.CreditNotes.Update.Request(
            memo: "Updated memo"
        )
        let api = Stripe.Billing.CreditNotes.API.update(id: "cn_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/cn_123")
    }

    @Test("Retrieve credit note URL generation")
    func testRetrieveCreditNote() throws {
        let api = Stripe.Billing.CreditNotes.API.retrieve(id: "cn_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/cn_123")
    }

    @Test("List credit notes URL generation")
    func testListCreditNotes() throws {
        let request = Stripe.Billing.CreditNotes.List.Request(
            customer: "cus_123",
            limit: 10
        )
        let api = Stripe.Billing.CreditNotes.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes")
        #expect(url.query?.contains("customer=cus_123") == true)
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Preview credit note URL generation")
    func testPreviewCreditNote() throws {
        let request = Stripe.Billing.CreditNotes.Preview.Request(
            invoice: "in_123",
            amount: 500
        )
        let api = Stripe.Billing.CreditNotes.API.preview(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/preview")
        #expect(url.query?.contains("invoice=in_123") == true)
        #expect(url.query?.contains("amount=500") == true)
    }

    @Test("Void credit note URL generation")
    func testVoidCreditNote() throws {
        let request = Stripe.Billing.CreditNotes.Void.Request()
        let api = Stripe.Billing.CreditNotes.API.void(id: "cn_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/cn_123/void")
    }

    @Test("List credit note lines URL generation")
    func testListCreditNoteLines() throws {
        let request = Stripe.Billing.CreditNotes.Lines.Request(limit: 5)
        let api = Stripe.Billing.CreditNotes.API.lines(id: "cn_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/cn_123/lines")
        #expect(url.query?.contains("limit=5") == true)
    }

    @Test("Preview credit note lines URL generation")
    func testPreviewCreditNoteLines() throws {
        let request = Stripe.Billing.CreditNotes.PreviewLines.Request(
            invoice: "in_123",
            limit: 10
        )
        let api = Stripe.Billing.CreditNotes.API.previewLines(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/credit_notes/preview/lines")
        #expect(url.query?.contains("invoice=in_123") == true)
        #expect(url.query?.contains("limit=10") == true)
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.CreditNotes.API.retrieve(id: "cn_123")
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
