//
//  Stripe Refunds Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Refunds_Types
@testable import Stripe_Types_Models

@Suite("Refunds Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct RefundsRouterTests {

    @Test("Creates correct URL for refund creation")
    func testCreateRefundURL() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let createRequest = Stripe.Refunds.Create.Request(
            amount: 1000,
            charge: "ch_123",
            reason: .requestedByCustomer
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/refunds")
    }

    @Test("Creates correct URL for refund retrieval")
    func testRetrieveRefundURL() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_123"))
        let api: Stripe.Refunds.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/refunds/re_123")

        // Round-trip test
        let match: Stripe.Refunds.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Refunds.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for refund update")
    func testUpdateRefundURL() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_123"))
        let updateRequest = Stripe.Refunds.Update.Request(
            metadata: ["key": "value"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/refunds/re_123")
    }

    @Test("Creates correct URL for listing refunds")
    func testListRefundsURL() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let listRequest = Stripe.Refunds.List.Request(
            charge: "ch_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/refunds")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["charge"] == "ch_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for refund cancellation")
    func testCancelRefundURL() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_123"))
        let api: Stripe.Refunds.API = .cancel(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/refunds/re_123/cancel")

        // Round-trip test
        let match: Stripe.Refunds.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.cancel))
        #expect(Stripe.Refunds.API.cases.cancel.extract(match) == id)
    }

    @Test("Handles POST method correctly for create")
    func testCreateRefundMethod() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let createRequest = Stripe.Refunds.Create.Request(
            amount: 500,
            paymentIntent: "pi_123"
        )
        let api: Stripe.Refunds.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveRefundMethod() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_456"))
        let api: Stripe.Refunds.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for update")
    func testUpdateRefundMethod() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_789"))
        let updateRequest = Stripe.Refunds.Update.Request()
        let api: Stripe.Refunds.API = .update(id: id, request: updateRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for list")
    func testListRefundsMethod() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let listRequest = Stripe.Refunds.List.Request(limit: 5)
        let api: Stripe.Refunds.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for cancel")
    func testCancelRefundMethod() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let id = try #require(Stripe.Refunds.Refund.ID(rawValue: "re_cancel"))
        let api: Stripe.Refunds.API = .cancel(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Tests list with date filters")
    func testListWithDateFilters() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let listRequest = Stripe.Refunds.List.Request(
            created: Stripe.DateFilter(gte: 1_609_459_200),
            limit: 25
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/refunds")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] != nil)
        #expect(queryDict["limit"] == "25")
    }

    @Test("Tests list with payment intent filter")
    func testListWithPaymentIntentFilter() throws {
        let router: Stripe.Refunds.API.Router = .init()

        let listRequest = Stripe.Refunds.List.Request(
            limit: 50,
            paymentIntent: "pi_123"
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/refunds")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["payment_intent"] == "pi_123")
        #expect(queryDict["limit"] == "50")
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
