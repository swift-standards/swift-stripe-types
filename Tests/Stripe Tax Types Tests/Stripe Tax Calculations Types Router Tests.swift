//
//  Stripe Tax Calculations Types Router Tests.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Tax_Types
@testable import Stripe_Types_Models

@Suite("Tax Calculations Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct TaxCalculationsRouterTests {
    let router = Stripe.Tax.Calculations.API.Router()

    @Test("Create calculation")
    func createCalculation() throws {
        let request = Stripe.Tax.Calculations.Create.Request(
            currency: .usd,
            lineItems: [
                .init(amount: 1000, quantity: 1)
            ]
        )
        let api = Stripe.Tax.Calculations.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/tax/calculations")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.create))
    }

    @Test("Retrieve calculation")
    func retrieveCalculation() throws {
        let calculationId: Stripe.Tax.Calculation.ID = "taxcalc_123"
        let api = Stripe.Tax.Calculations.API.retrieve(id: calculationId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax/calculations/taxcalc_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.retrieve))

        if case .retrieve(let id) = parsed {
            #expect(id == calculationId)
        }
    }

    @Test("List line items")
    func listLineItems() throws {
        let calculationId: Stripe.Tax.Calculation.ID = "taxcalc_123"
        let request = Stripe.Tax.Calculations.List.LineItems.Request(
            limit: 25,
            startingAfter: "li_456"
        )
        let api = Stripe.Tax.Calculations.API.listLineItems(id: calculationId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax/calculations/taxcalc_123/line_items")
        #expect(url.query?.contains("limit=25") == true)
        #expect(url.query?.contains("starting_after=li_456") == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.listLineItems))
    }

    @Test("List line items with all parameters")
    func listLineItemsAllParameters() throws {
        let calculationId: Stripe.Tax.Calculation.ID = "taxcalc_test"
        let request = Stripe.Tax.Calculations.List.LineItems.Request(
            endingBefore: "li_before",
            limit: 50,
            startingAfter: "li_after"
        )
        let api = Stripe.Tax.Calculations.API.listLineItems(id: calculationId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax/calculations/taxcalc_test/line_items")
        #expect(url.query?.contains("ending_before=li_before") == true)
        #expect(url.query?.contains("limit=50") == true)
        #expect(url.query?.contains("starting_after=li_after") == true)

        let urlRequest = try router.request(for: api)
        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.listLineItems))
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
