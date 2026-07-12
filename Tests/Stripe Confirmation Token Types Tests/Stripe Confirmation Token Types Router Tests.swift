import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting

@testable import Stripe_Confirmation_Token_Types
@testable import Stripe_Types_Models

@Suite("Confirmation Token Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ConfirmationTokenRouterTests {
    let router = Stripe.ConfirmationToken.API.Router()

    @Test("Retrieve confirmation token URL generation")
    func testRetrieveURL() throws {
        let id = ConfirmationToken.ID("cfrm_1234567890")
        let api = Stripe.ConfirmationToken.API.retrieve(id: id)

        let url = router.url(for: api)

        #expect(url.path == "/v1/confirmation_tokens/cfrm_1234567890")
    }

    @Test("Parse retrieve confirmation token URL")
    func testParseRetrieveURL() throws {
        let id = ConfirmationToken.ID("cfrm_test123")
        let api = Stripe.ConfirmationToken.API.retrieve(id: id)
        let request = try router.request(for: api)

        let parsedAPI = try router.match(request: request)

        guard case .retrieve(let parsedId) = parsedAPI else {
            Issue.record("Expected retrieve case")
            return
        }
        #expect(parsedId == "cfrm_test123")
    }

    @Test("Round-trip URL parsing")
    func testRoundTrip() throws {
        let original = Stripe.ConfirmationToken.API.retrieve(
            id: ConfirmationToken.ID("cfrm_roundtrip")
        )
        let request = try router.request(for: original)
        let parsed = try router.match(request: request)

        #expect(parsed == original)
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
