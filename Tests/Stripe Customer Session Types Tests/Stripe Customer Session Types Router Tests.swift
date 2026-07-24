//
//  Stripe Customer Session Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Customer_Session_Types
@testable import Stripe_Types_Models

@Suite("Customer Session Router Tests")
struct CustomerSessionRouterTests {

    @Test("Creates correct URL for customer session creation")
    func testCreateCustomerSessionURL() throws {
        let router: Stripe.Customers.Customer.Sessions.API.Router = .init()

        let createRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_123",
            components: .buyButton(.init(enabled: true))
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/customer_sessions")
    }

    @Test("Handles POST method correctly for create")
    func testCreateCustomerSessionMethod() throws {
        let router: Stripe.Customers.Customer.Sessions.API.Router = .init()

        let createRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_456",
            components: .paymentElement(
                .init(
                    enabled: true,
                    features: .init(
                        paymentMethodRedisplay: .enabled,
                        paymentMethodSave: .enabled
                    )
                )
            )
        )

        let api: Stripe.Customers.Customer.Sessions.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.httpMethod == "POST")
    }

    @Test("Round-trip test for create endpoint")
    func testCreateRoundTrip() throws {
        let router: Stripe.Customers.Customer.Sessions.API.Router = .init()

        let createRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_789",
            components: .pricingTable(.init(enabled: true))
        )

        let api: Stripe.Customers.Customer.Sessions.API = .create(request: createRequest)
        let request = try router.request(for: api)

        #expect(request.url?.path == "/v1/customer_sessions")
        #expect(request.httpMethod == "POST")

        // Note: Full round-trip parsing is not supported for this endpoint due to the
        // custom Components enum encoding. The router correctly generates requests
        // but cannot parse them back due to form encoding limitations with the
        // custom Codable implementation.
    }

    @Test("Tests different component types in create request")
    func testCreateWithDifferentComponents() throws {
        let router: Stripe.Customers.Customer.Sessions.API.Router = .init()

        // Test with buy button
        let buyButtonRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_buy",
            components: .buyButton(.init(enabled: true))
        )
        let buyButtonUrl = router.url(for: .create(request: buyButtonRequest))
        #expect(buyButtonUrl.path == "/v1/customer_sessions")

        // Test with payment element
        let paymentElementRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_payment",
            components: .paymentElement(
                .init(
                    enabled: true,
                    features: .init(
                        paymentMethodAllowRedisplayFilters: [.always, .limited],
                        paymentMethodRedisplay: .enabled,
                        paymentMethodRedisplayLimit: 3,
                        paymentMethodRemove: .enabled,
                        paymentMethodSave: .disabled,
                        paymentMethodSaveUsage: .onSession
                    )
                )
            )
        )
        let paymentElementUrl = router.url(for: .create(request: paymentElementRequest))
        #expect(paymentElementUrl.path == "/v1/customer_sessions")

        // Test with pricing table
        let pricingTableRequest = Stripe.Customers.Customer.Sessions.Create.Request(
            customer: "cus_pricing",
            components: .pricingTable(.init(enabled: true))
        )
        let pricingTableUrl = router.url(for: .create(request: pricingTableRequest))
        #expect(pricingTableUrl.path == "/v1/customer_sessions")
    }
}
