import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Payment_Methods_Types
@testable import Stripe_Types_Models

@Suite("Payment Method Domains Router Tests")
struct PaymentMethodDomainsRouterTests {
    let router = Stripe.PaymentMethodDomains.API.Router()

    @Test("Create payment method domain")
    func createPaymentMethodDomain() throws {
        let request = Stripe.PaymentMethodDomains.Create.Request(
            domainName: "example.com",
            enabled: true
        )
        let api = Stripe.PaymentMethodDomains.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/payment_method_domains")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        if case .create = parsed {
            // Expected
        } else {
            Issue.record("Expected create case")
        }
    }

    @Test("Retrieve payment method domain")
    func retrievePaymentMethodDomain() throws {
        let domainId: Stripe.PaymentMethodDomain.ID = "pmd_123"
        let api = Stripe.PaymentMethodDomains.API.retrieve(id: domainId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_method_domains/pmd_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        if case .retrieve(let id) = parsed {
            #expect(id == domainId)
        } else {
            Issue.record("Expected retrieve case")
        }
    }

    @Test("Update payment method domain")
    func updatePaymentMethodDomain() throws {
        let domainId: Stripe.PaymentMethodDomain.ID = "pmd_123"
        let request = Stripe.PaymentMethodDomains.Update.Request(
            enabled: false
        )
        let api = Stripe.PaymentMethodDomains.API.update(id: domainId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_method_domains/pmd_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        if case .update(let id, _) = parsed {
            #expect(id == domainId)
        } else {
            Issue.record("Expected update case")
        }
    }

    @Test("List payment method domains")
    func listPaymentMethodDomains() throws {
        let request = Stripe.PaymentMethodDomains.List.Request(
            domainName: "example.com",
            enabled: true,
            limit: 25
        )
        let api = Stripe.PaymentMethodDomains.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_method_domains")
        #expect(url.query?.contains("domain_name=example.com") == true)
        #expect(url.query?.contains("enabled=true") == true)
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

    @Test("Validate payment method domain")
    func validatePaymentMethodDomain() throws {
        let domainId: Stripe.PaymentMethodDomain.ID = "pmd_123"
        let api = Stripe.PaymentMethodDomains.API.validate(id: domainId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_method_domains/pmd_123/validate")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        if case .validate(let id) = parsed {
            #expect(id == domainId)
        } else {
            Issue.record("Expected validate case")
        }
    }

    @Test("List with pagination")
    func listWithPagination() throws {
        let request = Stripe.PaymentMethodDomains.List.Request(
            endingBefore: "pmd_100",
            limit: 50,
            startingAfter: "pmd_200"
        )
        let api = Stripe.PaymentMethodDomains.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/payment_method_domains")
        #expect(url.query?.contains("ending_before=pmd_100") == true)
        #expect(url.query?.contains("limit=50") == true)
        #expect(url.query?.contains("starting_after=pmd_200") == true)

        let urlRequest = try router.request(for: api)
        let parsed = try router.match(request: urlRequest)
        if case .list = parsed {
            // Expected
        } else {
            Issue.record("Expected list case")
        }
    }
}
