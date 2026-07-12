//
//  Stripe Billing Plans Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Plans Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct BillingPlansRouterTests {
    let router = Stripe.Billing.Plans.API.Router()

    @Test("Create plan URL generation")
    func testCreatePlan() throws {
        let request = Stripe.Billing.Plans.Create.Request(
            amount: 1000,
            currency: .usd,
            interval: .month,
            nickname: "Standard Plan"
        )
        let api = Stripe.Billing.Plans.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/plans")
    }

    @Test("Retrieve plan URL generation")
    func testRetrievePlan() throws {
        let api = Stripe.Billing.Plans.API.retrieve(id: "plan_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/plans/plan_123")
    }

    @Test("Update plan URL generation")
    func testUpdatePlan() throws {
        let request = Stripe.Billing.Plans.Update.Request(
            active: false,
            nickname: "Updated Plan"
        )
        let api = Stripe.Billing.Plans.API.update(id: "plan_123", request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/plans/plan_123")
    }

    @Test("List plans URL generation")
    func testListPlans() throws {
        let request = Stripe.Billing.Plans.List.Request(
            active: true,
            limit: 10,
            product: "prod_123"
        )
        let api = Stripe.Billing.Plans.API.list(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/plans")
        #expect(url.query?.contains("active=true") == true)
        #expect(url.query?.contains("limit=10") == true)
        #expect(url.query?.contains("product=prod_123") == true)
    }

    @Test("Delete plan URL generation")
    func testDeletePlan() throws {
        let api = Stripe.Billing.Plans.API.delete(id: "plan_123")
        let url = router.url(for: api)

        #expect(url.path == "/v1/plans/plan_123")
    }

    @Test("Round-trip parsing for retrieve")
    func testRoundTripRetrieve() throws {
        let original = Stripe.Billing.Plans.API.retrieve(id: "plan_123")
        let request = try router.request(for: original)
        let parsed = try router.match(request: request)
        #expect(parsed == original)
    }

    @Test("Round-trip parsing for delete")
    func testRoundTripDelete() throws {
        let original = Stripe.Billing.Plans.API.delete(id: "plan_123")
        let request = try router.request(for: original)
        #expect(request.httpMethod == "DELETE")
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
