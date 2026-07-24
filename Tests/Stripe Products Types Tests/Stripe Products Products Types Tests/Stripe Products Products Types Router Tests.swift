import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Products_Types
@testable import Stripe_Types_Models

@Suite("Products Products Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ProductsProductsRouterTests {

    @Test("Creates correct URL for product creation")
    func testCreateProductURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let createRequest = Stripe.Products.Products.Create.Request(
            name: "Test Product",
            description: "Test product description",
            metadata: ["category": "test"],
            defaultPriceData: Stripe.Products.Products.DefaultPrice.Data(
                currency: .usd,
                unitAmount: 2000
            )
        )

        let url = router.url(for: .create(request: createRequest))
        #expect(url.path == "/v1/products")
    }

    @Test("Creates correct URL for product retrieval")
    func testRetrieveProductURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let id = Stripe.Products.Product.ID("prod_123")
        let url = router.url(for: .retrieve(id: id))
        #expect(url.path == "/v1/products/prod_123")
    }

    @Test("Creates correct URL for product update")
    func testUpdateProductURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let id = Stripe.Products.Product.ID("prod_123")
        let updateRequest = Stripe.Products.Products.Update.Request(
            description: "Updated product",
            metadata: ["updated": "true"],
            name: "Updated Product Name"
        )

        let url = router.url(for: .update(id: id, request: updateRequest))
        #expect(url.path == "/v1/products/prod_123")
    }

    @Test("Creates correct URL for listing products")
    func testListProductsURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let listRequest = Stripe.Products.Products.List.Request(
            active: true,
            limit: 10,
            shippable: true
        )

        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/products")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["active"] == "true")
        #expect(queryDict["limit"] == "10")
        #expect(queryDict["shippable"] == "true")
    }

    @Test("Creates correct URL for deleting product")
    func testDeleteProductURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let id = Stripe.Products.Product.ID("prod_123")
        let url = router.url(for: .delete(id: id))
        #expect(url.path == "/v1/products/prod_123")
    }

    @Test("Creates correct URL for searching products")
    func testSearchProductsURL() throws {
        let router: Stripe.Products.Products.API.Router = .init()

        let searchRequest = Stripe.Products.Products.Search.Request(
            query: "active:'true' AND metadata['category']:'test'",
            limit: 10
        )

        let url = router.url(for: .search(request: searchRequest))
        #expect(url.path == "/v1/products/search")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](
            uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) }
        )

        #expect(queryDict["query"] == "active:'true' AND metadata['category']:'test'")
        #expect(queryDict["limit"] == "10")
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
