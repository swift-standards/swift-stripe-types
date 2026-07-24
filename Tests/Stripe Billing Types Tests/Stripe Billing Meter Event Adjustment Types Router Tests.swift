//
//  Stripe Billing Meter Event Adjustment Types Router Tests.swift
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

@Suite("Billing Meter Event Adjustments Router Tests")
struct BillingMeterEventAdjustmentsRouterTests {
    let router = Stripe.Billing.MeterEventAdjustments.API.Router()

    @Test("Create meter event adjustment URL generation")
    func testCreateAdjustment() throws {
        let request = Stripe.Billing.MeterEventAdjustments.Create.Request(
            eventName: "api_request",
            type: .cancel,
            cancel: .init(identifier: "evt_123")
        )
        let api = Stripe.Billing.MeterEventAdjustments.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/meter_event_adjustments")
    }

    @Test("Round-trip parsing for create")
    func testRoundTripCreate() throws {
        let request = Stripe.Billing.MeterEventAdjustments.Create.Request(
            eventName: "api_request",
            type: .cancel,
            cancel: .init(identifier: "unique_123")
        )
        let original = Stripe.Billing.MeterEventAdjustments.API.create(request: request)
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "POST")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }
}
