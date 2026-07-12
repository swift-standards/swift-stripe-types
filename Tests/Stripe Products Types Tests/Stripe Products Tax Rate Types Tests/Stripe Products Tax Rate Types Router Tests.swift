import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Products_Types
@testable import Stripe_Types_Models

@Suite("Products Tax Rates Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ProductsTaxRatesRouterTests {
    let router = Stripe.Products.TaxRates.API.Router()

    @Test("Create tax rate")
    func createTaxRate() throws {
        let request = Stripe.Products.TaxRates.Create.Request(
            displayName: "VAT",
            inclusive: true,
            percentage: 20
        )
        let api = Stripe.Products.TaxRates.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/tax_rates")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.create))
    }

    @Test("Retrieve tax rate")
    func retrieveTaxRate() throws {
        let taxRateId: Stripe.Tax.Rate.ID = "txr_123"
        let api = Stripe.Products.TaxRates.API.retrieve(id: taxRateId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax_rates/txr_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.retrieve))

        if case .retrieve(let id) = parsed {
            #expect(id == taxRateId)
        }
    }

    @Test("Update tax rate")
    func updateTaxRate() throws {
        let taxRateId: Stripe.Tax.Rate.ID = "txr_123"
        let request = Stripe.Products.TaxRates.Update.Request(
            active: false,
            description: "Updated tax rate"
        )
        let api = Stripe.Products.TaxRates.API.update(id: taxRateId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax_rates/txr_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.update))

        if case .update(let id, _) = parsed {
            #expect(id == taxRateId)
        }
    }

    @Test("List tax rates")
    func listTaxRates() throws {
        let request = Stripe.Products.TaxRates.List.Request(
            active: true,
            inclusive: false,
            limit: 25
        )
        let api = Stripe.Products.TaxRates.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax_rates")
        #expect(url.query?.contains("active=true") == true)
        #expect(url.query?.contains("inclusive=false") == true)
        #expect(url.query?.contains("limit=25") == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        if case .list = parsed {
            // Expected
        } else {
            Issue.record("Expected list case")
        }
    }

    @Test("List tax rates with all parameters")
    func listTaxRatesAllParameters() throws {
        let created = Stripe.DateFilter(gte: 1_609_459_200)
        let request = Stripe.Products.TaxRates.List.Request(
            active: false,
            created: created,
            endingBefore: "txr_100",
            inclusive: true,
            limit: 50,
            startingAfter: "txr_200"
        )
        let api = Stripe.Products.TaxRates.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/tax_rates")
        #expect(url.query?.contains("active=false") == true)
        #expect(url.query?.contains("inclusive=true") == true)
        #expect(url.query?.contains("limit=50") == true)

        let urlRequest = try router.request(for: api)
        let parsed = try router.match(request: urlRequest)
        if case .list = parsed {
            // Expected
        } else {
            Issue.record("Expected list case")
        }
    }

    @Test("Create tax rate with all parameters")
    func createTaxRateAllParameters() throws {
        let request = Stripe.Products.TaxRates.Create.Request(
            displayName: "Sales Tax",
            inclusive: false,
            percentage: 8.75,
            active: true,
            country: "US",
            description: "California sales tax",
            jurisdiction: "California",
            metadata: ["region": "west"],
            state: "CA",
            taxType: .salesTax
        )
        let api = Stripe.Products.TaxRates.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/tax_rates")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.create))
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
