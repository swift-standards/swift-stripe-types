import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types

@Suite("Usage Records Router Tests")
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
        #expect(path.method == "POST")

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
        #expect(path.method == "GET")

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
        #expect(path.method == "GET")
    }
}
