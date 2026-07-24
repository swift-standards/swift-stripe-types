import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Connect_Types
@testable import Stripe_Types_Models

@Suite("Connect Accounts Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ConnectAccountsRouterTests {
    let router = Stripe.Connect.Accounts.API.Router()

    @Test("Create account route")
    func testCreateRoute() throws {
        let request = Stripe.Connect.Accounts.Create.Request(
            country: "US",
            email: "test@example.com",
            type: .standard
        )

        let api = Stripe.Connect.Accounts.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }

    @Test("Retrieve account route")
    func testRetrieveRoute() throws {
        let id = Stripe.Connect.Account.ID("acct_123")
        let api = Stripe.Connect.Accounts.API.retrieve(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts/acct_123")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
    }

    @Test("Update account route")
    func testUpdateRoute() throws {
        let id = Stripe.Connect.Account.ID("acct_456")
        let request = Stripe.Connect.Accounts.Update.Request(
            email: "updated@example.com"
        )

        let api = Stripe.Connect.Accounts.API.update(id: id, request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts/acct_456")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.update))
    }

    @Test("List accounts route")
    func testListRoute() throws {
        let request = Stripe.Connect.Accounts.List.Request(
            limit: 10,
            startingAfter: "acct_last"
        )

        let api = Stripe.Connect.Accounts.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts")
        #expect(url.query == "limit=10&starting_after=acct_last")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.list))
    }

    @Test("Delete account route")
    func testDeleteRoute() throws {
        let id = Stripe.Connect.Account.ID("acct_789")
        let api = Stripe.Connect.Accounts.API.delete(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts/acct_789")

        let request = try router.request(for: api)
        // Verification is done via round-trip test

        // Round-trip test
        let match = try router.match(request: request)
        #expect(match.is(\.delete))
    }

    @Test("Reject account route")
    func testRejectRoute() throws {
        let id = Stripe.Connect.Account.ID("acct_999")
        let request = Stripe.Connect.Accounts.Reject.Request(reason: .fraud)

        let api = Stripe.Connect.Accounts.API.reject(id: id, request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/accounts/acct_999/reject")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.reject))
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
