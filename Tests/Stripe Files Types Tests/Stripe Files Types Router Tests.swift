//
//  Stripe Files Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Files_Types
@testable import Stripe_Types_Models

@Suite("Files Router Tests")
struct FilesRouterTests {

    @Test("Creates correct URL for file creation")
    func testCreateFileURL() throws {
        let router: Stripe.Files.API.Router = .init()

        let createRequest = Stripe.Files.Create.Request(
            file: Data(),
            purpose: .disputeEvidence
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/files")
    }

    @Test("Creates correct URL for file retrieval")
    func testRetrieveFileURL() throws {
        let router: Stripe.Files.API.Router = .init()

        let id = try #require(Stripe.Files.File.ID(rawValue: "file_123"))
        let api: Stripe.Files.API = .retrieve(id: id)

        let url = router.url(for: api)
        #expect(url.path == "/v1/files/file_123")

        // Round-trip test
        let match: Stripe.Files.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(match.retrieve == id)
    }

    @Test("Creates correct URL for listing files")
    func testListFilesURL() throws {
        let router: Stripe.Files.API.Router = .init()

        let listRequest = Stripe.Files.List.Request(
            limit: 10,
            purpose: .identityDocument
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/files")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["limit"] == "10")
        #expect(queryDict["purpose"] == "identity_document")
    }

    @Test("Handles POST method correctly for create")
    func testCreateFileMethod() throws {
        let router: Stripe.Files.API.Router = .init()

        let createRequest = Stripe.Files.Create.Request(
            file: Data(),
            purpose: .disputeEvidence
        )
        let api: Stripe.Files.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Handles GET method correctly for retrieve")
    func testRetrieveFileMethod() throws {
        let router: Stripe.Files.API.Router = .init()

        let id = try #require(Stripe.Files.File.ID(rawValue: "file_456"))
        let api: Stripe.Files.API = .retrieve(id: id)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Handles GET method correctly for list")
    func testListFilesMethod() throws {
        let router: Stripe.Files.API.Router = .init()

        let listRequest = Stripe.Files.List.Request(limit: 5)
        let api: Stripe.Files.API = .list(request: listRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "GET")
    }

    @Test("Tests list with date filter")
    func testListWithDateFilter() throws {
        let router: Stripe.Files.API.Router = .init()

        let listRequest = Stripe.Files.List.Request(
            created: Stripe.DateFilter(gt: 1_609_459_200),
            limit: 5
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/files")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["created"] != nil)
        #expect(queryDict["limit"] == "5")
    }
}
