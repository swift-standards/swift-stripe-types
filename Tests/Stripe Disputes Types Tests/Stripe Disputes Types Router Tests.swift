//
//  Stripe Disputes Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Disputes_Types
@testable import Stripe_Types_Models

@Suite("Disputes Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct DisputesRouterTests {

    @Test("Creates correct URL for dispute retrieval")
    func testRetrieveDisputeURL() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_123"))
        let api: Stripe.Disputes.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/disputes/dp_123")

        // Round-trip test
        let match: Stripe.Disputes.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Disputes.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for dispute update")
    func testUpdateDisputeURL() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_123"))
        let updateRequest = Stripe.Disputes.Update.Request(
            evidence: .init(
                customerCommunication: "Email exchange",
                productDescription: "Digital subscription"
            ),
            metadata: ["case": "12345"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/disputes/dp_123")
    }

    @Test("Creates correct URL for listing disputes")
    func testListDisputesURL() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let listRequest = Stripe.Disputes.List.Request(
            charge: "ch_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/disputes")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["charge"] == "ch_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for closing dispute")
    func testCloseDisputeURL() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_456"))
        let api: Stripe.Disputes.API = .close(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/disputes/dp_456/close")

        // Round-trip test
        let match: Stripe.Disputes.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.close))
        #expect(Stripe.Disputes.API.cases.close.extract(match) == id)
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveDisputeMethod() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_789"))
        let api: Stripe.Disputes.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for update")
    func testUpdateDisputeMethod() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_789"))
        let updateRequest = Stripe.Disputes.Update.Request(
            submit: true
        )
        let api: Stripe.Disputes.API = .update(id: id, request: updateRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles POST method correctly for close")
    func testCloseDisputeMethod() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let id = try #require(Stripe.Disputes.Dispute.ID(rawValue: "dp_close"))
        let api: Stripe.Disputes.API = .close(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Tests list with date filter")
    func testListWithDateFilter() throws {
        let router: Stripe.Disputes.API.Router = .init()

        let listRequest = Stripe.Disputes.List.Request(
            created: Stripe.DateFilter(gt: 1_609_459_200),
            limit: 5
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/disputes")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] != nil)
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
