//
//  Stripe Products Tax Rate Types Router Tests.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Products_Tax_Rate_Types
@testable import Stripe_Types_Models

@Suite("Tax Rate Router Tests")
struct TaxRateRouterTests {
    let router = Stripe.Products.TaxRates.API.Router()

    @Test("Create tax rate route")
    func testCreateRoute() throws {
        let request = Stripe.Products.TaxRates.Create.Request(
            displayName: "VAT",
            inclusive: false,
            percentage: 20.0,
            active: true,
            country: "GB",
            description: "Value Added Tax",
            jurisdiction: "UK",
            metadata: ["key": "value"],
            state: nil,
            taxType: .vat
        )

        let route = Stripe.Products.TaxRates.API.create(request: request)
        let (method, path, _) = try router.parse(route)

        #expect(method == .post)
        #expect(path == "/v1/tax_rates")
    }

    @Test("Retrieve tax rate route")
    func testRetrieveRoute() throws {
        let id = try #require(Stripe.Tax.Rate.ID(rawValue: "txr_1234567890"))
        let route = Stripe.Products.TaxRates.API.retrieve(id: id)
        let (method, path, _) = try router.parse(route)

        #expect(method == .get)
        #expect(path == "/v1/tax_rates/txr_1234567890")
    }

    @Test("Update tax rate route")
    func testUpdateRoute() throws {
        let id = try #require(Stripe.Tax.Rate.ID(rawValue: "txr_1234567890"))
        let request = Stripe.Products.TaxRates.Update.Request(
            active: false,
            description: "Updated description"
        )

        let route = Stripe.Products.TaxRates.API.update(id: id, request: request)
        let (method, path, _) = try router.parse(route)

        #expect(method == .post)
        #expect(path == "/v1/tax_rates/txr_1234567890")
    }

    @Test("List tax rates route")
    func testListRoute() throws {
        let request = Stripe.Products.TaxRates.List.Request(
            active: true,
            inclusive: false,
            limit: 10
        )

        let route = Stripe.Products.TaxRates.API.list(request: request)
        let (method, path, _) = try router.parse(route)

        #expect(method == .get)
        #expect(path == "/v1/tax_rates")
    }

    @Test("List with pagination")
    func testListWithPagination() throws {
        let request = Stripe.Products.TaxRates.List.Request(
            limit: 50,
            startingAfter: "txr_last"
        )

        let route = Stripe.Products.TaxRates.API.list(request: request)
        let url = try router.request(for: route).url

        #expect(url?.query?.contains("limit=50") == true)
        #expect(url?.query?.contains("starting_after=txr_last") == true)
    }

    @Test("Round-trip parsing")
    func testRoundTrip() throws {
        let id = try #require(Stripe.Tax.Rate.ID(rawValue: "txr_test123"))
        let originalRoute = Stripe.Products.TaxRates.API.retrieve(id: id)

        let request = try router.request(for: originalRoute)
        let parsedRoute = try router.route(for: request)

        #expect(parsedRoute == originalRoute)
    }
}
