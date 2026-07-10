import Foundation
import Testing
import URLRouting

@testable import Stripe_Customers_Types
@testable import Stripe_Payment_Intents_Types
@testable import Stripe_Products_Types
@testable import Stripe_Types
@testable import Stripe_Types_Models

@Suite("README Code Examples Validation")
struct ReadmeVerificationTests {

    // MARK: - Quick Start Examples (README lines 34-51)

    @Test("Type-safe resource IDs (README lines 40-41)")
    func typeSeafeResourceIDs() {
        // Type-safe resource IDs
        let customerId: Stripe.Customers.Customer.ID = "cus_123"
        let paymentIntentId: Stripe.PaymentIntents.PaymentIntent.ID = "pi_456"

        #expect(customerId.rawValue == "cus_123")
        #expect(paymentIntentId.rawValue == "pi_456")
    }

    @Test("Strongly-typed requests (README lines 44-47)")
    func stronglyTypedRequests() {
        // Strongly-typed requests
        let createCustomer = Stripe.Customers.Create.Request(
            email: "customer@example.com",
            name: "John Doe"
        )

        #expect(createCustomer.email == "customer@example.com")
        #expect(createCustomer.name == "John Doe")
    }

    @Test("Client type exists (README line 50)")
    func clientTypeExists() {
        // Client definition (implementations in swift-stripe-live)
        let _: Stripe.Customers.Client.Type = Stripe.Customers.Client.self

        // Verify it's Sendable
        #expect(Stripe.Customers.Client.self is any Sendable.Type)
    }

    // MARK: - Type Safety with Tagged IDs (README lines 132-139)

    @Test("Type Safety with Tagged IDs (README lines 132-139)")
    func typeSafetyWithTaggedIDs() {
        // Can't accidentally mix IDs
        let customerId: Stripe.Customers.Customer.ID = "cus_123"
        let productId: Stripe.Products.Product.ID = "prod_456"

        // Verify the IDs are different types
        #expect(customerId.rawValue == "cus_123")
        #expect(productId.rawValue == "prod_456")
        #expect(type(of: customerId) != type(of: productId))
    }

    // MARK: - Request/Response Pattern (README lines 146-164)

    @Test("Request/Response Pattern (README lines 146-164)")
    func requestResponsePattern() {
        // Verify Create.Request structure
        let createRequest = Stripe.Customers.Create.Request(
            email: "test@example.com",
            name: "Test User"
        )

        let _: any Codable = createRequest
        let _: any Equatable = createRequest
        let _: any Sendable = createRequest

        // Verify List types
        let listRequest = Stripe.Customers.List.Request()
        let _: any Codable = listRequest

        let listResponse = Stripe.Customers.List.Response(
            object: "list",
            url: "/v1/customers",
            hasMore: false,
            data: []
        )

        #expect(listResponse.object == "list")
        #expect(listResponse.hasMore == false)
        let _: any Sendable = listResponse
    }

    // MARK: - URL Routing (README lines 171-183)

    @Test("URL Routing (README lines 171-183)")
    func urlRouting() throws {
        let router = Stripe.Customers.API.Router()

        // Verify API enum cases exist
        let _ = Stripe.Customers.API.create(
            request: Stripe.Customers.Create.Request()
        )
        let retrieveAPI = Stripe.Customers.API.retrieve(id: "cus_123")
        let _ = Stripe.Customers.API.update(
            id: "cus_123",
            request: Stripe.Customers.Update.Request()
        )
        let _ = Stripe.Customers.API.list(
            request: Stripe.Customers.List.Request()
        )
        let _ = Stripe.Customers.API.delete(id: "cus_123")

        // Verify Equatable
        #expect(retrieveAPI == retrieveAPI)

        // Verify router can generate URLs
        let url = router.url(for: retrieveAPI)
        #expect(url.path == "/v1/customers/cus_123")

        // Verify round-trip
        let request = try router.request(for: retrieveAPI)
        let matched = try router.match(request: request)
        #expect(matched.is(\.retrieve))
    }

    // MARK: - Testing Pattern (README lines 189-221)

    @Test("Testing Pattern (README lines 189-221)")
    func testingPattern() async throws {
        // README shows plain `throw TestError()` closures; the actual Client
        // slots are now typed-throws(Witness.Unimplemented.Error), so the
        // unimplemented endpoints below throw that typed error instead
        // (nested @Witness clients get it for free via `.unimplemented()`).
        @Sendable func unimplemented(
            _ operation: String,
            fileID: String = #fileID,
            filePath: String = #filePath,
            line: Int = #line,
            column: Int = #column
        ) -> Witness.Unimplemented.Error {
            Witness.Unimplemented.Error(
                witness: "Stripe.Customers.Client",
                operation: operation,
                location: Source_Primitives.Source.Location(fileID: fileID, filePath: filePath, line: line, column: column)
            )
        }

        // Create mock client as shown in README
        let mockClient = Stripe.Customers.Client(
            create: { request in
                Stripe.Customers.Customer(
                    id: "cus_test",
                    email: request.email,
                    name: request.name,
                    object: "customer",
                    created: Date()
                )
            },
            update: { (_, _) async throws(Witness.Unimplemented.Error) in throw unimplemented("update") },
            retrieve: { (_) async throws(Witness.Unimplemented.Error) in throw unimplemented("retrieve") },
            list: { (_) async throws(Witness.Unimplemented.Error) in throw unimplemented("list") },
            delete: { (_) async throws(Witness.Unimplemented.Error) in throw unimplemented("delete") },
            search: { (_) async throws(Witness.Unimplemented.Error) in throw unimplemented("search") },
            bankAccounts: .unimplemented(),
            cards: .unimplemented(),
            cashBalance: .unimplemented(),
            cashBalanceTransactions: .unimplemented()
        )

        // Test with mock
        let request = Stripe.Customers.Create.Request(
            email: "test@example.com",
            name: "Test User"
        )
        let customer = try await mockClient.create(request)
        #expect(customer.id.rawValue == "cus_test")
        #expect(customer.email == "test@example.com")
        #expect(customer.name == "Test User")
    }
}
