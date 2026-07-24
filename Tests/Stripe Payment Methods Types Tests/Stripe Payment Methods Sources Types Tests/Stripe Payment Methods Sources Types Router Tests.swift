import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Payment_Methods_Types
@testable import Stripe_Types_Models

@Suite("Payment Methods Sources Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct PaymentMethodsSourcesRouterTests {
    let router = Stripe.PaymentMethods.Sources.API.Router()

    @Test("Create source")
    func createSource() throws {
        let request = Stripe.PaymentMethods.Sources.Create.Request(
            type: "card",
            amount: 1000,
            currency: .usd
        )
        let api = Stripe.PaymentMethods.Sources.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/sources")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.create))
    }

    @Test("Retrieve source")
    func retrieveSource() throws {
        let sourceId: Stripe_Types_Models.Source.ID = "src_123"
        let api = Stripe.PaymentMethods.Sources.API.retrieve(id: sourceId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/sources/src_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.retrieve))

        if case .retrieve(let id) = parsed {
            #expect(id == sourceId)
        }
    }

    @Test("Update source")
    func updateSource() throws {
        let sourceId: Stripe_Types_Models.Source.ID = "src_123"
        let request = Stripe.PaymentMethods.Sources.Update.Request(
            amount: 2000,
            metadata: ["key": "value"]
        )
        let api = Stripe.PaymentMethods.Sources.API.update(id: sourceId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/sources/src_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.update))

        if case .update(let id, _) = parsed {
            #expect(id == sourceId)
        }
    }

    @Test("Attach source to customer")
    func attachSource() throws {
        let customerId: Stripe.Customers.Customer.ID = "cus_123"
        let sourceId: Stripe_Types_Models.Source.ID = "src_456"
        let api = Stripe.PaymentMethods.Sources.API.attach(customerId: customerId, source: sourceId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_123/sources")
        #expect(url.query?.contains("source=src_456") == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.attach))

        if case .attach(let cId, let sId) = parsed {
            #expect(cId == customerId)
            #expect(sId == sourceId)
        }
    }

    @Test("Detach source from customer")
    func detachSource() throws {
        let customerId: Stripe.Customers.Customer.ID = "cus_123"
        let sourceId: Stripe_Types_Models.Source.ID = "src_456"
        let api = Stripe.PaymentMethods.Sources.API.detach(
            customerId: customerId,
            sourceId: sourceId
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_123/sources/src_456")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "DELETE")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.detach))

        if case .detach(let cId, let sId) = parsed {
            #expect(cId == customerId)
            #expect(sId == sourceId)
        }
    }

    @Test("Create source with complex request")
    func createSourceComplex() throws {
        let owner = Stripe.PaymentMethods.Sources.Create.Owner(
            email: "test@example.com",
            name: "Test User",
            phone: "+1234567890"
        )
        let redirect = Stripe.PaymentMethods.Sources.Create.Redirect(
            returnUrl: "https://example.com/return"
        )

        let request = Stripe.PaymentMethods.Sources.Create.Request(
            type: "ideal",
            amount: 5000,
            currency: .eur,
            flow: "redirect",
            owner: owner,
            redirect: redirect,
            usage: "single_use"
        )
        let api = Stripe.PaymentMethods.Sources.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/sources")
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
