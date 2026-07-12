//
//  Stripe Payouts Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Payouts_Types
@testable import Stripe_Types_Models

@Suite("Payouts Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct PayoutsRouterTests {

    @Test("Creates correct URL for payout creation")
    func testCreatePayoutURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let createRequest = Stripe.Payouts.Create.Request(
            amount: 1000,
            currency: .usd,
            description: "Test payout"
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/payouts")
    }

    @Test("Creates correct URL for payout retrieval")
    func testRetrievePayoutURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_123"))
        let api: Stripe.Payouts.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payouts/po_123")

        // Round-trip test
        let match: Stripe.Payouts.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Payouts.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for payout update")
    func testUpdatePayoutURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_123"))
        let updateRequest = Stripe.Payouts.Update.Request(
            metadata: ["key": "value"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/payouts/po_123")
    }

    @Test("Creates correct URL for listing payouts")
    func testListPayoutsURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let listRequest = Stripe.Payouts.List.Request(
            created: Stripe.DateFilter(gte: 1_609_459_200),
            limit: 10,
            status: .pending
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/payouts")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] != nil)
        #expect(queryDict["limit"] == "10")
        #expect(queryDict["status"] == "pending")
    }

    @Test("Creates correct URL for payout cancellation")
    func testCancelPayoutURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_123"))
        let api: Stripe.Payouts.API = .cancel(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payouts/po_123/cancel")

        // Round-trip test
        let match: Stripe.Payouts.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.cancel))
        #expect(Stripe.Payouts.API.cases.cancel.extract(match) == id)
    }

    @Test("Creates correct URL for payout reversal")
    func testReversePayoutURL() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_123"))
        let api: Stripe.Payouts.API = .reverse(id: id, request: .init(metadata: ["key": "value"]))

        let url = router.url(for: api)
        #expect(url.path == "/v1/payouts/po_123/reverse")

        // Round-trip test
        let match: Stripe.Payouts.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.reverse))
        #expect(Stripe.Payouts.API.cases.reverse.extract(match)?.id == id)
    }

    @Test("Handles POST method correctly for create")
    func testCreatePayoutMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let createRequest = Stripe.Payouts.Create.Request(
            amount: 500,
            currency: .eur
        )
        let api: Stripe.Payouts.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrievePayoutMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_456"))
        let api: Stripe.Payouts.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for update")
    func testUpdatePayoutMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_789"))
        let updateRequest = Stripe.Payouts.Update.Request()
        let api: Stripe.Payouts.API = .update(id: id, request: updateRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for list")
    func testListPayoutsMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let listRequest = Stripe.Payouts.List.Request(limit: 5)
        let api: Stripe.Payouts.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for cancel")
    func testCancelPayoutMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_cancel"))
        let api: Stripe.Payouts.API = .cancel(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles POST method correctly for reverse")
    func testReversePayoutMethod() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let id = try #require(Stripe.Payouts.Payout.ID(rawValue: "po_reverse"))
        let api: Stripe.Payouts.API = .reverse(id: id, request: .init())
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Tests list with date filters")
    func testListWithDateFilters() throws {
        let router: Stripe.Payouts.API.Router = .init()

        let listRequest = Stripe.Payouts.List.Request(
            arrivalDate: Stripe.DateFilter(gt: 1_609_459_200),
            created: Stripe.DateFilter(lte: 1_612_137_600),
            limit: 25
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/payouts")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["arrival_date"] != nil)
        #expect(queryDict["created"] != nil)
        #expect(queryDict["limit"] == "25")
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
