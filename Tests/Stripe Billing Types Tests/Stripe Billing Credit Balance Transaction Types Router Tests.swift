import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Credit Balance Transaction Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct CreditBalanceTransactionRouterTests {

    @Test("Retrieve credit balance transaction URL generation")
    func testRetrieveURL() throws {
        let router = Stripe.Billing.Credit.Balance.API.Router()
        let transactionId = Stripe.Billing.Credit.Balance.Transaction.ID("cbtxn_test123")
        let api = Stripe.Billing.Credit.Balance.API.retrieve(id: transactionId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/billing/credit_balance_transactions/cbtxn_test123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")
    }

    @Test("List credit balance transactions URL generation")
    func testListURL() throws {
        let router = Stripe.Billing.Credit.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test456")
        let request = Stripe.Billing.Credit.Balance.List.Request(
            customer: customerId,
            creditGrant: "cg_test789",
            limit: 20,
            startingAfter: "cbtxn_start"
        )
        let api = Stripe.Billing.Credit.Balance.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/billing/credit_balance_transactions")

        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let hasCustomer = urlComponents.queryItems?.contains {
            $0.name == "customer" && $0.value == "cus_test456"
        }
        let hasCreditGrant = urlComponents.queryItems?.contains {
            $0.name == "credit_grant" && $0.value == "cg_test789"
        }
        let hasLimit = urlComponents.queryItems?.contains { $0.name == "limit" && $0.value == "20" }
        let hasStartingAfter = urlComponents.queryItems?.contains {
            $0.name == "starting_after" && $0.value == "cbtxn_start"
        }

        #expect(hasCustomer == true)
        #expect(hasCreditGrant == true)
        #expect(hasLimit == true)
        #expect(hasStartingAfter == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")
    }

    @Test("Router round trip parsing")
    func testRouterRoundTrip() throws {
        let router = Stripe.Billing.Credit.Balance.API.Router()
        let transactionId = Stripe.Billing.Credit.Balance.Transaction.ID("cbtxn_test123")
        let originalAPI = Stripe.Billing.Credit.Balance.API.retrieve(id: transactionId)

        let urlRequest = try router.request(for: originalAPI)
        let parsedAPI = try router.match(request: urlRequest)

        #expect(parsedAPI == originalAPI)
    }

    @Test("List router round trip parsing")
    func testListRouterRoundTrip() throws {
        let router = Stripe.Billing.Credit.Balance.API.Router()
        let customerId = Stripe.Customers.Customer.ID("cus_test456")
        let request = Stripe.Billing.Credit.Balance.List.Request(
            customer: customerId,
            limit: 50
        )
        let originalAPI = Stripe.Billing.Credit.Balance.API.list(request: request)

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
