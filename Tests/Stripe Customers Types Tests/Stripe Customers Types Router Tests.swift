//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Customers_Types
@testable import Stripe_Types_Models

@Suite("Customer Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct CustomerRouterTests {

    @Test("Creates correct URL for customer creation")
    func testCreateCustomerURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let createRequest = Stripe.Customers.Create.Request(
            description: "Test customer",
            email: "test@example.com",
            metadata: ["order_id": "12345"],
            name: "Test Customer"
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/customers")
    }

    @Test("Creates correct URL for customer retrieval")
    func testRetrieveCustomerURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let id = try #require(Stripe.Customers.Customer.ID(rawValue: "cus_123"))
        let api: Stripe.Customers.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_123")

        // Round-trip test
        let match: Stripe.Customers.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.Customers.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for customer update")
    func testUpdateCustomerURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let id = try #require(Stripe.Customers.Customer.ID(rawValue: "cus_123"))
        let updateRequest = Stripe.Customers.Update.Request(
            description: "Updated customer",
            metadata: ["updated": "true"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/customers/cus_123")
    }

    @Test("Creates correct URL for listing customers")
    func testListCustomersURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let listRequest = Stripe.Customers.List.Request(
            email: "test@example.com",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/customers")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["email"] == "test@example.com")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Creates correct URL for deleting customer")
    func testDeleteCustomerURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let id = try #require(Stripe.Customers.Customer.ID(rawValue: "cus_123"))
        let api: Stripe.Customers.API = .delete(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_123")

        // Round-trip test
        let match: Stripe.Customers.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.delete))
        #expect(Stripe.Customers.API.cases.delete.extract(match) == id)
    }

    @Test("Creates correct URL for searching customers")
    func testSearchCustomersURL() throws {
        let router: Stripe.Customers.API.Router = .init()

        let searchRequest = Stripe.Customers.Search.Request(
            query: "email:'test@example.com' AND metadata['order_id']:'12345'",
            limit: 10
        )

        let url = router.url(for: .search(request: searchRequest))
        #expect(url.path == "/v1/customers/search")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["query"] == "email:'test@example.com' AND metadata['order_id']:'12345'")
        #expect(queryDict["limit"] == "10")
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
