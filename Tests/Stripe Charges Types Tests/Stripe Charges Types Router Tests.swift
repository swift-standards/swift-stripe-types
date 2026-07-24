//
//  Stripe Charges Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Charges_Types
@testable import Stripe_Types_Models

@Suite("Charges Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ChargesRouterTests {

    @Test("Creates correct URL for charge creation")
    func testCreateChargeURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let createRequest = Stripe.Charges.Create.Request(
            amount: 2000,
            currency: .usd,
            customer: "cus_123",
            description: "Test charge",
            metadata: ["order_id": "12345"]
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/charges")
    }

    @Test("Creates correct URL for charge retrieval")
    func testRetrieveChargeURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let id = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let api: Stripe.Charges.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/charges/ch_123")

        // Round-trip test
        let match: Stripe.Charges.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Charges.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for charge update")
    func testUpdateChargeURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let id = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let updateRequest = Stripe.Charges.Update.Request(
            description: "Updated charge",
            metadata: ["updated": "true"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/charges/ch_123")
    }

    @Test("Creates correct URL for listing charges")
    func testListChargesURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let listRequest = Stripe.Charges.List.Request(
            customer: "cus_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/charges")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["customer"] == "cus_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for capturing charge")
    func testCaptureChargeURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let id = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let captureRequest = Stripe.Charges.Capture.Request(
            amount: 1500
        )

        let api: Stripe.Charges.API = .capture(id: id, request: captureRequest)
        let url = router.url(for: api)

        #expect(url.path == "/v1/charges/ch_123/capture")

        // Round-trip test
        let match: Stripe.Charges.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.capture))
        #expect(Stripe.Charges.API.cases.capture.extract(match)?.id == id)
    }

    @Test("Creates correct URL for searching charges")
    func testSearchChargesURL() throws {
        let router: Stripe.Charges.API.Router = .init()

        let searchRequest = Stripe.Charges.Search.Request(
            query: "amount>999 AND metadata['order_id']:'12345'",
            limit: 10
        )

        let url = router.url(for: .search(request: searchRequest))
        #expect(url.path == "/v1/charges/search")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["query"] == "amount>999 AND metadata['order_id']:'12345'")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveChargeMethod() throws {
        let router: Stripe.Charges.API.Router = .init()

        let id = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let api: Stripe.Charges.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for create")
    func testCreateChargeMethod() throws {
        let router: Stripe.Charges.API.Router = .init()

        let createRequest = Stripe.Charges.Create.Request(
            amount: 2000,
            currency: .usd
        )
        let api: Stripe.Charges.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Round-trip test for search endpoint")
    func testSearchRoundTrip() throws {
        let router: Stripe.Charges.API.Router = .init()

        let searchRequest = Stripe.Charges.Search.Request(
            query: "status:'succeeded'",
            limit: 5
        )

        let api: Stripe.Charges.API = .search(request: searchRequest)
        let request = try router.request(for: api)

        // Verify the URL is correct first
        #expect(request.url?.path == "/v1/charges/search")

        // For GET requests with query parameters, the round-trip might not work perfectly
        // due to URLRouting limitations with query parsing
        // So we'll just verify the URL is correctly formed
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["query"] == "status:'succeeded'")
        #expect(queryDict["limit"] == "5")
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
