import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Capital_Types
@testable import Stripe_Types_Models

@Suite("Capital Financing Summary Router Tests")
struct CapitalFinancingSummaryRouterTests {
    let router = Stripe.Capital.FinancingSummary.API.Router()

    @Test("Retrieve financing summary")
    func retrieveFinancingSummary() throws {
        let api = Stripe.Capital.FinancingSummary.API.retrieve

        let url = router.url(for: api)
        #expect(url.path == "/v1/capital/financing_summary")

        let request = try router.request(for: api)
        let parsed = try router.match(request: request)
        #expect(parsed == api)
    }
}
