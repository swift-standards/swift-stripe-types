//
//  Stripe Fraud Early Fraud Warning Types Router Tests.swift
//  swift-stripe-types
//
//  Regression coverage for F-004: the `.list` route on
//  `Stripe.Fraud.EarlyFraudWarnings.API` was commented out of the `Router`
//  (a query-parsing blocker at the time), while the `API` enum and `Client`
//  both still declared `list` cases — so calling `.list` could never produce
//  a request. This asserts every `API` case actually round-trips through the
//  `Router`, which would have failed red before the route was implemented
//  (`Router.init()` matching would either not compile against a `.list` case
//  with no route, or — pre-fix, with the case still present but unrouted —
//  `router.request(for: .list(...))` would fail to produce a URL at all).

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting

@testable import Stripe_Fraud_Types
@testable import Stripe_Types_Models

extension Stripe.Fraud.EarlyFraudWarnings.API {
    @Suite(
        "Early Fraud Warnings API Router",
        .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4")
    )
    struct Tests {
        @Suite struct Unit {}
    }
}

extension Stripe.Fraud.EarlyFraudWarnings.API.Tests.Unit {
    @Test("Every API case round-trips through the Router")
    func everyAPICaseRoundTripsThroughTheRouter() throws {
        let router = Stripe.Fraud.EarlyFraudWarnings.API.Router()

        // .retrieve
        let warningID = try #require(
            Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.ID(rawValue: "issfr_123")
        )
        let retrieve: Stripe.Fraud.EarlyFraudWarnings.API = .retrieve(id: warningID)
        let retrieveURL = router.url(for: retrieve)
        #expect(retrieveURL.path == "/v1/radar/early_fraud_warnings/issfr_123")

        let retrieveMatch = try router.match(request: try router.request(for: retrieve))
        #expect(retrieveMatch.is(\.retrieve))
        #expect(Stripe.Fraud.EarlyFraudWarnings.API.cases.retrieve.extract(retrieveMatch) == warningID)

        // .list — the case whose route was commented out (F-004).
        let chargeID = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let paymentIntentID = try #require(Stripe.PaymentIntents.PaymentIntent.ID(rawValue: "pi_123"))
        let listRequest = Stripe.Fraud.EarlyFraudWarnings.API.List.Request(
            charge: chargeID,
            paymentIntent: paymentIntentID,
            endingBefore: "issfr_000",
            limit: 5,
            startingAfter: "issfr_001"
        )
        let list: Stripe.Fraud.EarlyFraudWarnings.API = .list(request: listRequest)
        let listURL = router.url(for: list)
        #expect(listURL.path == "/v1/radar/early_fraud_warnings")

        let listMatch = try router.match(request: try router.request(for: list))
        #expect(listMatch.is(\.list))
        #expect(Stripe.Fraud.EarlyFraudWarnings.API.cases.list.extract(listMatch) == listRequest)
    }

    @Test("List route encodes query parameters")
    func listRouteEncodesQueryParameters() throws {
        let router = Stripe.Fraud.EarlyFraudWarnings.API.Router()

        let listRequest = Stripe.Fraud.EarlyFraudWarnings.API.List.Request(limit: 10)
        let url = router.url(for: .list(request: listRequest))
        #expect(url.path == "/v1/radar/early_fraud_warnings")

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        let queryDict = [String: String?](uniqueKeysWithValues: queryItems.map { ($0.name, $0.value) })
        #expect(queryDict["limit"] == "10")
    }

    @Test("List route uses GET")
    func listRouteUsesGET() throws {
        let router = Stripe.Fraud.EarlyFraudWarnings.API.Router()

        let listRequest = Stripe.Fraud.EarlyFraudWarnings.API.List.Request()
        let request = try router.request(for: .list(request: listRequest))
        #expect(request.httpMethod == "GET")
    }
}

// §A9 toolchain gate (swift-institute/Research/swift-compiler-bug-catalog.md §A9):
// institute `Tagged` materialized inside this router's deep generic parser chains
// forces its value-witness table at first parse/print; on Swift 6.3.x
// `swift_getTypeByMangledName` returns null metadata and the test runner SIGSEGVs.
// Fixed in Swift 6.4; no source fix exists (graph-package ratified pattern —
// `.disabled(if:)`, not `withKnownIssue`, because the crash kills the runner).
// Auto-retires at the 6.4 toolchain move.
//
// Empirically confirmed (not just inherited boilerplate) during this fix: a
// contained probe with the guard temporarily forced `false` reproduced the
// SIGSEGV (signal 11) both for the full suite and for a `.retrieve`-only
// isolation case (the pre-existing, untouched-by-F-004 case alone) — see
// REPORT.md section (d) for the captured crash logs.
#if compiler(<6.4)
private let taggedMetadataSIGSEGV = true
#else
private let taggedMetadataSIGSEGV = false
#endif
