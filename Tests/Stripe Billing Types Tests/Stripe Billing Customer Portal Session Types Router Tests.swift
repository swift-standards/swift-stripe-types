import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Customer Portal Session Router Tests")
struct BillingCustomerPortalSessionRouterTests {
    let router = Stripe.Billing.Customer.Portal.Session.API.Router()

    @Test("Create portal session route")
    func testCreateRoute() throws {
        let request = Stripe.Billing.Customer.Portal.Session.Create.Request(
            customer: "cus_123",
            configuration: "bpc_123",
            returnUrl: "https://example.com/account"
        )

        let api = Stripe.Billing.Customer.Portal.Session.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing_portal/sessions")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }

    @Test("Create portal session with flow data")
    func testCreateWithFlowData() throws {
        let request = Stripe.Billing.Customer.Portal.Session.Create.Request(
            customer: "cus_123",
            flowData: .init(
                afterCompletion: .init(
                    hostedConfirmation: nil,
                    redirect: .init(returnUrl: "https://example.com/done"),
                    type: .redirect
                ),
                type: .subscriptionCancel,
                subscriptionUpdate: nil,
                subscriptionUpdateConfirm: nil,
                subscriptionCancel: .init(subscription: "sub_123")
            )
        )

        let api = Stripe.Billing.Customer.Portal.Session.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/billing_portal/sessions")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }
}
