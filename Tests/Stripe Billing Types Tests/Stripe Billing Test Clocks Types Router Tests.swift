//
//  Stripe Billing Test Clocks Types Router Tests.swift
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

@Suite("Billing Test Clocks Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingTestClocksRouterTests {
    let router = Stripe.Billing.TestClocks.API.Router()

    @Test("Create test clock URL generation")
    func testCreateTestClock() throws {
        let request = Stripe.Billing.TestClocks.Create.Request(
            frozenTime: 1_609_459_200,
            name: "My Test Clock"
        )
        let api = Stripe.Billing.TestClocks.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/test_helpers/test_clocks")
    }

    @Test("Retrieve test clock URL generation")
    func testRetrieveTestClock() throws {
        let api = Stripe.Billing.TestClocks.API.retrieve(id: "clock_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/test_helpers/test_clocks/clock_123")
    }

    @Test("List test clocks URL generation")
    func testListTestClocks() throws {
        let request = Stripe.Billing.TestClocks.List.Request(
            limit: 20,
            startingAfter: "clock_456"
        )
        let api = Stripe.Billing.TestClocks.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/test_helpers/test_clocks")
        #expect(url.query?.contains("limit=20") == true)
        #expect(url.query?.contains("starting_after=clock_456") == true)
    }

    @Test("Delete test clock URL generation")
    func testDeleteTestClock() throws {
        let api = Stripe.Billing.TestClocks.API.delete(id: "clock_789")
        let url = router.url(for: api)

        #expect(url.path == "/v1/test_helpers/test_clocks/clock_789")
    }

    @Test("Advance test clock URL generation")
    func testAdvanceTestClock() throws {
        let request = Stripe.Billing.TestClocks.Advance.Request(
            frozenTime: 1_609_545_600
        )
        let api = Stripe.Billing.TestClocks.API.advance(id: "clock_999", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/test_helpers/test_clocks/clock_999/advance")
    }

    @Test("Round-trip parsing for create")
    func testRoundTripCreate() throws {
        let request = Stripe.Billing.TestClocks.Create.Request(
            frozenTime: 1_609_459_200
        )
        let original = Stripe.Billing.TestClocks.API.create(request: request)
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "POST")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.TestClocks.API.retrieve(id: "clock_xyz")
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "GET")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for delete")
    func testRoundTripDelete() throws {
        let original = Stripe.Billing.TestClocks.API.delete(id: "clock_del")
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "DELETE")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for advance")
    func testRoundTripAdvance() throws {
        let request = Stripe.Billing.TestClocks.Advance.Request(
            frozenTime: 1_609_545_600
        )
        let original = Stripe.Billing.TestClocks.API.advance(id: "clock_adv", request: request)
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "POST")
        let parsed = try router.match(request: urlRequest)
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
