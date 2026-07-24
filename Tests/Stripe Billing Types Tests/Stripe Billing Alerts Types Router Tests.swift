import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Alerts Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingAlertsRouterTests {
    let router = Stripe.Billing.Alerts.API.Router()

    @Test("Create alert route")
    func testCreateRoute() throws {
        let request = Stripe.Billing.Alerts.Create.Request(
            alertType: .usageThreshold,
            title: "High Usage Alert",
            usageThreshold: .init(
                filters: nil,
                gte: 1000,
                meter: "meter_123",
                recurrence: .oneTime
            )
        )

        let api = Stripe.Billing.Alerts.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }

    @Test("Retrieve alert route")
    func testRetrieveRoute() throws {
        let id: Stripe.Billing.Alerts.Alert.ID = "alrt_123"
        let api = Stripe.Billing.Alerts.API.retrieve(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts/alrt_123")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
    }

    @Test("List alerts route")
    func testListRoute() throws {
        let request = Stripe.Billing.Alerts.List.Request(
            alertType: .usageThreshold,
            limit: 10,
            meter: "meter_123"
        )

        let api = Stripe.Billing.Alerts.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts")
        #expect(url.query == "alert_type=usage_threshold&limit=10&meter=meter_123")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.list))
    }

    @Test("Activate alert route")
    func testActivateRoute() throws {
        let id: Stripe.Billing.Alerts.Alert.ID = "alrt_123"
        let api = Stripe.Billing.Alerts.API.activate(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts/alrt_123/activate")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.activate))
    }

    @Test("Archive alert route")
    func testArchiveRoute() throws {
        let id: Stripe.Billing.Alerts.Alert.ID = "alrt_123"
        let api = Stripe.Billing.Alerts.API.archive(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts/alrt_123/archive")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.archive))
    }

    @Test("Deactivate alert route")
    func testDeactivateRoute() throws {
        let id: Stripe.Billing.Alerts.Alert.ID = "alrt_123"
        let api = Stripe.Billing.Alerts.API.deactivate(id: id)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/alerts/alrt_123/deactivate")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.deactivate))
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
