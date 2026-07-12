import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types

@Suite("Usage Records Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct UsageRecordsRouterTests {
    let router = Stripe.Billing.UsageRecords.API.Router()
    let subscriptionItemId: Stripe.Billing.SubscriptionItems.SubscriptionItem.ID

    init() throws {
        subscriptionItemId = try #require(
            Stripe.Billing.SubscriptionItems.SubscriptionItem.ID(rawValue: "si_1234567890")
        )
    }

    @Test("Create usage record endpoint")
    func testCreateRoute() throws {
        let request = Stripe.Billing.UsageRecords.Create.Request(
            quantity: 100,
            timestamp: .right(.now)
        )

        let api = Stripe.Billing.UsageRecords.API.create(
            subscriptionItemId: subscriptionItemId,
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/subscription_items/si_1234567890/usage_records")

        let path = try router.print(api)
        #expect(path.method == .post)

        // Test round trip
        let parsed = try router.parse(path)
        #expect(parsed == api)
    }

    @Test("List usage records endpoint")
    func testListRoute() throws {
        let request = Stripe.Billing.UsageRecords.List.Request(
            limit: 10
        )

        let api = Stripe.Billing.UsageRecords.API.list(
            subscriptionItemId: subscriptionItemId,
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/subscription_items/si_1234567890/usage_records")
        #expect(url.query == "limit=10")

        let path = try router.print(api)
        #expect(path.method == .get)

        // Test round trip
        let parsed = try router.parse(path)
        #expect(parsed == api)
    }

    @Test("List with pagination")
    func testListWithPagination() throws {
        let request = Stripe.Billing.UsageRecords.List.Request(
            endingBefore: "ur_before",
            limit: 50,
            startingAfter: "ur_after"
        )

        let api = Stripe.Billing.UsageRecords.API.list(
            subscriptionItemId: subscriptionItemId,
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/subscription_items/si_1234567890/usage_records")
        #expect(url.query?.contains("ending_before=ur_before") == true)
        #expect(url.query?.contains("limit=50") == true)
        #expect(url.query?.contains("starting_after=ur_after") == true)

        let path = try router.print(api)
        #expect(path.method == .get)
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
