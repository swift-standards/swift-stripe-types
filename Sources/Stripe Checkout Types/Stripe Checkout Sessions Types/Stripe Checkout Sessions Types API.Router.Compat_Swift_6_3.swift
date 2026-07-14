//
//  Stripe Checkout Sessions Types API.Router.Compat_Swift_6_3.swift
//  swift-stripe-types
//
//  ┌───────────────────────────────────────────────────────────────────────────┐
//  │  6.3.x-COMPAT PATH — §A9-CLASS — RETIRES-OR-REDISPOSES AT THE 6.4 FLIP.    │
//  └───────────────────────────────────────────────────────────────────────────┘
//
//  Sibling of `Stripe Customers Types API.Router.Compat_Swift_6_3.swift` — see that
//  file's header for the full §A9 rationale. Same bug, same shape: the generated
//  `Stripe.Checkout.Sessions.API.Router` carries `{id}` path components whose
//  parsers close over `Tagged<Stripe.Checkout.Session, String>`, and a router is
//  instantiated as a UNIT, so printing `create` through it forces those witness
//  tables and SIGSEGVs on 6.3.x.
//
//  This is a create-only parser-printer whose route body is a VERBATIM COPY of the
//  `.create` branch of `Stripe.Checkout.Sessions.API.Router.body`
//  (`Stripe Checkout Sessions Types API.swift`).
//
//  Grep token: `Compat_Swift_6_3`.
//  Catalog: swift-institute/Research/swift-compiler-bug-catalog.md §A9.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Checkout.Sessions.API.Router {
    /// 6.3.x-compat (§A9) create-only router — see the file header.
    ///
    /// Prints `POST /v1/checkout/sessions` with a `.stripe`-encoded form body, exactly
    /// as ``Stripe/Checkout/Sessions/API/Router`` does for
    /// ``Stripe/Checkout/Sessions/API/create(request:)``. Printing any other route
    /// throws — the caller is expected to reject non-`create` routes with a named
    /// compat error before reaching this router.
    ///
    /// - Warning: 6.3.x-compat path, §A9-class. RETIRES-OR-REDISPOSES AT THE 6.4 FLIP.
    public struct Compat_Swift_6_3: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Checkout.Sessions.API> {
            // ▼ VERBATIM COPY of Stripe.Checkout.Sessions.API.Router.body's `.create`
            //   branch. Keep in sync until the 6.4 flip deletes this type.
            URLRouting.Route(.case(Stripe.Checkout.Sessions.API.cases.create)) {
                Method.post
                Path.v1
                Path.checkout
                Path.sessions
                URLRouting.Body(
                    .form(
                        Stripe.Checkout.Sessions.Create.Request.self,
                        decoder: .stripe,
                        encoder: .stripe
                    )
                )
            }
        }
    }
}
