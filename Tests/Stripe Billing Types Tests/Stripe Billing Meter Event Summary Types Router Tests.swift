//
//  Stripe Billing Meter Event Summary Types Router Tests.swift
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

@Suite("Billing Meter Event Summary Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingMeterEventSummaryRouterTests {
    let router = Stripe.Billing.MeterEventSummary.API.Router()

    @Test("List meter event summaries URL generation")
    func testListSummaries() throws {
        let request = Stripe.Billing.MeterEventSummary.List.Request(
            customer: "cus_123",
            startTime: 1_609_459_200,
            endTime: 1_609_545_600,
            valueGroupingWindow: .hour
        )
        let api = Stripe.Billing.MeterEventSummary.API.list(meterId: "mtr_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/meters/mtr_123/event_summaries")
        #expect(url.query?.contains("customer=cus_123") == true)
        #expect(url.query?.contains("start_time=1609459200") == true)
        #expect(url.query?.contains("end_time=1609545600") == true)
        #expect(url.query?.contains("value_grouping_window=hour") == true)
    }

    @Test("Round-trip parsing for list")
    func testRoundTripList() throws {
        let request = Stripe.Billing.MeterEventSummary.List.Request(
            customer: "cus_456",
            startTime: 1_609_459_200,
            endTime: 1_609_545_600,
            valueGroupingWindow: .day,
            limit: 20
        )
        let original = Stripe.Billing.MeterEventSummary.API.list(
            meterId: "mtr_456",
            request: request
        )
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "GET")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }

    @Test("List with pagination parameters")
    func testListWithPagination() throws {
        let request = Stripe.Billing.MeterEventSummary.List.Request(
            customer: "cus_789",
            startTime: 1_609_459_200,
            endTime: 1_609_545_600,
            endingBefore: "evt_before",
            limit: 50,
            startingAfter: "evt_after"
        )
        let api = Stripe.Billing.MeterEventSummary.API.list(meterId: "mtr_789", request: request)
        let url = router.url(for: api)

        #expect(url.query?.contains("ending_before=evt_before") == true)
        #expect(url.query?.contains("limit=50") == true)
        #expect(url.query?.contains("starting_after=evt_after") == true)
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
