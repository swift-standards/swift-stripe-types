//
//  Stripe Billing Meter Events Types Router Tests.swift
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

@Suite("Billing Meter Events Router Tests")
struct BillingMeterEventsRouterTests {
    let router = Stripe.Billing.MeterEvents.API.Router()

    @Test("Create meter event URL generation")
    func testCreateMeterEvent() throws {
        let request = Stripe.Billing.MeterEvents.Create.Request(
            eventName: "api_request",
            timestamp: Date(),
            payload: ["customer_id": "cus_123", "value": "10"]
        )
        let api = Stripe.Billing.MeterEvents.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing/meter_events")
    }

    @Test("Round-trip parsing for create")
    func testRoundTripCreate() throws {
        let request = Stripe.Billing.MeterEvents.Create.Request(
            eventName: "api_request",
            identifier: "unique_123",
            // Whole-second timestamp: the `.stripe` form coder encodes dates as
            // integer seconds (`String(Int(timeIntervalSince1970))`), so a
            // fractional `Date()` can never round-trip to exact equality.
            timestamp: Date(timeIntervalSince1970: 1_700_000_000),
            payload: ["customer_id": "cus_123"]
        )
        let original = Stripe.Billing.MeterEvents.API.create(request: request)
        let urlRequest = try router.request(for: original)
        #expect(urlRequest.httpMethod == "POST")
        let parsed = try router.match(request: urlRequest)
        #expect(parsed == original)
    }
}
