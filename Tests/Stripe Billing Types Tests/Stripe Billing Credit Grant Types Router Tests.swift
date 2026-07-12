import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Credit Grant Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct CreditGrantRouterTests {
    let router = Stripe.Billing.Credit.Grant.API.Router()

    @Test("Create credit grant route")
    func testCreateRoute() throws {
        let request = Stripe.Billing.Credit.Grant.Create.Request(
            amount: .init(
                monetary: .init(currency: .usd, value: 1000),
                type: "monetary"
            ),
            applicabilityConfig: .init(
                scope: .init(priceType: "metered", prices: nil)
            ),
            category: .promotional,
            customer: "cus_123"
        )

        let api = Stripe.Billing.Credit.Grant.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }

    @Test("Retrieve credit grant route")
    func testRetrieveRoute() throws {
        let id = Stripe.Billing.Credit.Grant.ID("credgr_123")
        let api = Stripe.Billing.Credit.Grant.API.retrieve(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants/credgr_123")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
    }

    @Test("Update credit grant route")
    func testUpdateRoute() throws {
        let id = Stripe.Billing.Credit.Grant.ID("credgr_123")
        let request = Stripe.Billing.Credit.Grant.Update.Request(
            metadata: ["key": "value"]
        )

        let api = Stripe.Billing.Credit.Grant.API.update(id: id, request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants/credgr_123")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.update))
    }

    @Test("List credit grants route")
    func testListRoute() throws {
        let request = Stripe.Billing.Credit.Grant.List.Request(
            customer: "cus_123",
            limit: 10
        )

        let api = Stripe.Billing.Credit.Grant.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants")
        #expect(url.query == "customer=cus_123&limit=10")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.list))
    }

    @Test("Expire credit grant route")
    func testExpireRoute() throws {
        let id = Stripe.Billing.Credit.Grant.ID("credgr_123")
        let request = Stripe.Billing.Credit.Grant.Expire.Request()

        let api = Stripe.Billing.Credit.Grant.API.expire(id: id, request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants/credgr_123/expire")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.expire))
    }

    @Test("Void credit grant route")
    func testVoidRoute() throws {
        let id = Stripe.Billing.Credit.Grant.ID("credgr_123")
        let request = Stripe.Billing.Credit.Grant.Void.Request()

        let api = Stripe.Billing.Credit.Grant.API.void(id: id, request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/credit_grants/credgr_123/void")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.void))
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
