//
//  Stripe File Links Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_File_Links_Types
@testable import Stripe_Types_Models

@Suite("File Links Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct FileLinksRouterTests {

    @Test("Creates correct URL for file link creation")
    func testCreateFileLinkURL() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let createRequest = Stripe.FileLinks.Create.Request(
            file: "file_123",
            expiresAt: Date(timeIntervalSince1970: 1_609_459_200)
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/file_links")
    }

    @Test("Creates correct URL for file link retrieval")
    func testRetrieveFileLinkURL() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let id = try #require(Stripe.FileLinks.FileLink.ID(rawValue: "link_123"))
        let api: Stripe.FileLinks.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/file_links/link_123")

        // Round-trip test
        let match: Stripe.FileLinks.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(Stripe.FileLinks.API.cases.retrieve.extract(match) == id)
    }

    @Test("Creates correct URL for file link update")
    func testUpdateFileLinkURL() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let id = try #require(Stripe.FileLinks.FileLink.ID(rawValue: "link_123"))
        let updateRequest = Stripe.FileLinks.Update.Request(
            metadata: ["key": "value"]
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/file_links/link_123")
    }

    @Test("Creates correct URL for listing file links")
    func testListFileLinksURL() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let listRequest = Stripe.FileLinks.List.Request(
            expired: false,
            file: "file_123",
            limit: 10
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/file_links")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["expired"] == "false")
        #expect(queryDict["file"] == "file_123")
        #expect(queryDict["limit"] == "10")
    }

    @Test("Handles POST method correctly for create")
    func testCreateFileLinkMethod() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let createRequest = Stripe.FileLinks.Create.Request(file: "file_456")
        let api: Stripe.FileLinks.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveFileLinkMethod() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let id = try #require(Stripe.FileLinks.FileLink.ID(rawValue: "link_456"))
        let api: Stripe.FileLinks.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles POST method correctly for update")
    func testUpdateFileLinkMethod() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let id = try #require(Stripe.FileLinks.FileLink.ID(rawValue: "link_789"))
        let updateRequest = Stripe.FileLinks.Update.Request()
        let api: Stripe.FileLinks.API = .update(id: id, request: updateRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for list")
    func testListFileLinksMethod() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let listRequest = Stripe.FileLinks.List.Request(limit: 5)
        let api: Stripe.FileLinks.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Tests list with date filter")
    func testListWithDateFilter() throws {
        let router: Stripe.FileLinks.API.Router = .init()

        let listRequest = Stripe.FileLinks.List.Request(
            created: Stripe.DateFilter(gt: 1_609_459_200),
            limit: 5
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/file_links")

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
