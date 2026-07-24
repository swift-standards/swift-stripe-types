//
//  Stripe Billing Subscription Schedule Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Subscription Schedule Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingSubscriptionScheduleRouterTests {
    let router = Stripe.Billing.Subscription.Schedule.API.Router()

    @Test("Create subscription schedule URL generation")
    func testCreateSubscriptionSchedule() throws {
        let request = Stripe.Billing.Subscription.Schedule.Create.Request(
            customer: "cus_123",
            endBehavior: .release
        )
        let api = Stripe.Billing.Subscription.Schedule.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules")
    }

    @Test("Retrieve subscription schedule URL generation")
    func testRetrieveSubscriptionSchedule() throws {
        let api = Stripe.Billing.Subscription.Schedule.API.retrieve(id: "sub_sched_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules/sub_sched_123")
    }

    @Test("Update subscription schedule URL generation")
    func testUpdateSubscriptionSchedule() throws {
        let request = Stripe.Billing.Subscription.Schedule.Update.Request(
            endBehavior: .cancel
        )
        let api = Stripe.Billing.Subscription.Schedule.API.update(
            id: "sub_sched_123",
            request: request
        )
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules/sub_sched_123")
    }

    @Test("List subscription schedules URL generation")
    func testListSubscriptionSchedules() throws {
        let request = Stripe.Billing.Subscription.Schedule.List.Request(
            customer: "cus_123",
            limit: 10,
            scheduled: true
        )
        let api = Stripe.Billing.Subscription.Schedule.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules")
        #expect(url.query?.contains("customer=cus_123") == true)
        #expect(url.query?.contains("limit=10") == true)
        #expect(url.query?.contains("scheduled=true") == true)
    }

    @Test("Cancel subscription schedule URL generation")
    func testCancelSubscriptionSchedule() throws {
        let request = Stripe.Billing.Subscription.Schedule.Cancel.Request(
            invoiceNow: true,
            prorate: false
        )
        let api = Stripe.Billing.Subscription.Schedule.API.cancel(
            id: "sub_sched_123",
            request: request
        )
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules/sub_sched_123/cancel")
    }

    @Test("Release subscription schedule URL generation")
    func testReleaseSubscriptionSchedule() throws {
        let request = Stripe.Billing.Subscription.Schedule.Release.Request(
            preserveCancelDate: true
        )
        let api = Stripe.Billing.Subscription.Schedule.API.release(
            id: "sub_sched_123",
            request: request
        )
        let url = router.url(for: api)

        #expect(url.path == "/v1/subscription_schedules/sub_sched_123/release")
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.Subscription.Schedule.API.retrieve(id: "sub_sched_123")
        let request = try router.request(for: original)
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for cancel")
    func testRoundTripCancel() throws {
        let cancelRequest = Stripe.Billing.Subscription.Schedule.Cancel.Request()
        let original = Stripe.Billing.Subscription.Schedule.API.cancel(
            id: "sub_sched_123",
            request: cancelRequest
        )
        let request = try router.request(for: original)
        #expect(request.httpMethod == "POST")
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for release")
    func testRoundTripRelease() throws {
        let releaseRequest = Stripe.Billing.Subscription.Schedule.Release.Request()
        let original = Stripe.Billing.Subscription.Schedule.API.release(
            id: "sub_sched_123",
            request: releaseRequest
        )
        let request = try router.request(for: original)
        #expect(request.httpMethod == "POST")
        let parsed = try router.match(request: request)
        #expect(parsed == original)
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
