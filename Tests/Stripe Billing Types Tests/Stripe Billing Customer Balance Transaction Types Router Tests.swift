import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Customer Balance Transaction Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct CustomerBalanceTransactionRouterTests {

    @Test("Create customer balance transaction URL generation")
    func testCreateURL() throws {
        let router = Stripe.Billing.Customer.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test123")
        let request = Stripe.Billing.Customer.Balance.Create.Request(
            amount: -500,
            currency: .usd,
            description: "Test credit"
        )
        let api = Stripe.Billing.Customer.Balance.API.create(
            customerId: customerId,
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_test123/balance_transactions")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")
    }

    @Test("Retrieve customer balance transaction URL generation")
    func testRetrieveURL() throws {
        let router = Stripe.Billing.Customer.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test123")
        let transactionId = Stripe.Billing.Customer.Balance.Transaction.ID("cbtxn_test456")
        let api = Stripe.Billing.Customer.Balance.API.retrieve(
            customerId: customerId,
            id: transactionId
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_test123/balance_transactions/cbtxn_test456")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")
    }

    @Test("Update customer balance transaction URL generation")
    func testUpdateURL() throws {
        let router = Stripe.Billing.Customer.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test123")
        let transactionId = Stripe.Billing.Customer.Balance.Transaction.ID("cbtxn_test456")
        let request = Stripe.Billing.Customer.Balance.Update.Request(
            description: "Updated description"
        )
        let api = Stripe.Billing.Customer.Balance.API.update(
            customerId: customerId,
            id: transactionId,
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_test123/balance_transactions/cbtxn_test456")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")
    }

    @Test("List customer balance transactions URL generation")
    func testListURL() throws {
        let router = Stripe.Billing.Customer.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test123")
        let request = Stripe.Billing.Customer.Balance.List.Request(
            limit: 20,
            startingAfter: "cbtxn_start"
        )
        let api = Stripe.Billing.Customer.Balance.API.list(customerId: customerId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/customers/cus_test123/balance_transactions")

        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let hasLimit = urlComponents.queryItems?.contains { $0.name == "limit" && $0.value == "20" }
        let hasStartingAfter = urlComponents.queryItems?.contains {
            $0.name == "starting_after" && $0.value == "cbtxn_start"
        }

        #expect(hasLimit == true)
        #expect(hasStartingAfter == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")
    }

    @Test("Router round trip parsing")
    func testRouterRoundTrip() throws {
        let router = Stripe.Billing.Customer.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test123")
        let request = Stripe.Billing.Customer.Balance.Create.Request(
            amount: -1000,
            currency: .eur
        )
        let originalAPI = Stripe.Billing.Customer.Balance.API.create(
            customerId: customerId,
            request: request
        )

        let urlRequest = try router.request(for: originalAPI)
        let parsedAPI = try router.match(request: urlRequest)

        #expect(parsedAPI == originalAPI)
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
