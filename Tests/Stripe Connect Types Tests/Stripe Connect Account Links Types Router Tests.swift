import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Connect_Types
@testable import Stripe_Types_Models

@Suite("Connect Account Links Router Tests")
struct ConnectAccountLinksRouterTests {
    let router = Stripe.Connect.AccountLinks.API.Router()

    @Test("Create account link route")
    func testCreateRoute() throws {
        let request = Stripe.Connect.AccountLinks.Create.Request(
            account: "acct_123",
            type: .accountOnboarding,
            refreshUrl: "https://example.com/refresh",
            returnUrl: "https://example.com/return",
            collectionOptions: .init(
                fields: .eventuallyDue,
                futureRequirements: .include
            )
        )

        let api = Stripe.Connect.AccountLinks.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/account_links")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }

    @Test("Create account link with deprecated collect parameter")
    func testCreateWithCollectRoute() throws {
        let request = Stripe.Connect.AccountLinks.Create.Request(
            account: "acct_456",
            type: .accountUpdate,
            refreshUrl: "https://example.com/refresh",
            returnUrl: "https://example.com/return",
            collect: .currentlyDue
        )

        let api = Stripe.Connect.AccountLinks.API.create(request: request)
        let url = router.url(for: api)

        #expect(url.path == "/v1/account_links")

        // Round-trip test
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
    }
}
