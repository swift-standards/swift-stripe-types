import Foundation
import Stripe_Types_Shared
import Tagged_Primitives
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Connect_Types
@testable import Stripe_Types_Models

@Suite("Connect Transfers Router Tests", .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4"))
struct ConnectTransfersRouterTests {
    let router = Stripe.Connect.Transfers.API.Router()

    @Test("Create transfer")
    func createTransfer() throws {
        let request = Stripe.Connect.Transfers.Create.Request(
            amount: 1000,
            currency: .usd,
            destination: "acct_123"
        )
        let api = Stripe.Connect.Transfers.API.create(request: request)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.url?.path == "/v1/transfers")
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.create))
    }

    @Test("Retrieve transfer")
    func retrieveTransfer() throws {
        let transferId: Stripe.Connect.Transfer.ID = "tr_123"
        let api = Stripe.Connect.Transfers.API.retrieve(id: transferId)

        let url = router.url(for: api)
        #expect(url.path == "/v1/transfers/tr_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.retrieve))

        if case .retrieve(let id) = parsed {
            #expect(id == transferId)
        }
    }

    @Test("Update transfer")
    func updateTransfer() throws {
        let transferId: Stripe.Connect.Transfer.ID = "tr_123"
        let request = Stripe.Connect.Transfers.Update.Request(
            description: "Updated description",
            metadata: ["key": "value"]
        )
        let api = Stripe.Connect.Transfers.API.update(id: transferId, request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/transfers/tr_123")

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "POST")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.update))

        if case .update(let id, _) = parsed {
            #expect(id == transferId)
        }
    }

    @Test("List transfers")
    func listTransfers() throws {
        let request = Stripe.Connect.Transfers.List.Request(
            destination: "acct_123",
            limit: 25,
            startingAfter: "tr_456"
        )
        let api = Stripe.Connect.Transfers.API.list(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/transfers")
        #expect(url.query?.contains("destination=acct_123") == true)
        #expect(url.query?.contains("limit=25") == true)
        #expect(url.query?.contains("starting_after=tr_456") == true)

        let urlRequest = try router.request(for: api)
        #expect(urlRequest.httpMethod == "GET")

        let parsed = try router.match(request: urlRequest)
        #expect(parsed.is(\.list))
    }

    //    @Test("List transfers with all parameters")
    //    func listTransfersAllParameters() throws {
    //        let created = Stripe.DateFilter.exact(Date(timeIntervalSince1970: 1609459200))
    //        let request = Stripe.Connect.Transfers.List.Request(
    //            created: created,
    //            destination: "acct_123",
    //            endingBefore: "tr_100",
    //            limit: 50,
    //            startingAfter: "tr_200",
    //            transferGroup: "GROUP_123"
    //        )
    //        let api = Stripe.Connect.Transfers.API.list(request: request)
    //
    //        let url = router.url(for: api)
    //        #expect(url.path == "/v1/transfers")
    //        #expect(url.query?.contains("destination=acct_123") == true)
    //        #expect(url.query?.contains("limit=50") == true)
    //        #expect(url.query?.contains("transfer_group=GROUP_123") == true)
    //
    //        let urlRequest = try router.request(for: api)
    //        let parsed = try router.match(request: urlRequest)
    //        #expect(parsed.is(\.list))
    //    }
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
