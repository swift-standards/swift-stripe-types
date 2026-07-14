//
//  Stripe Customers Types API.Router.Compat_Swift_6_3.swift
//  swift-stripe-types
//
//  ┌───────────────────────────────────────────────────────────────────────────┐
//  │  6.3.x-COMPAT PATH — §A9-CLASS — RETIRES-OR-REDISPOSES AT THE 6.4 FLIP.    │
//  └───────────────────────────────────────────────────────────────────────────┘
//
//  WHY THIS EXISTS
//  ---------------
//  On the Swift 6.3.x toolchain, instantiating `Stripe.Customers.API.Router`'s
//  parser body SIGSEGVs inside the runtime's lazy protocol-witness-table
//  instantiation:
//
//      instantiateWitnessTable → swift::_getWitnessTable →
//      lazy protocol witness table accessor for
//        Parser.Converted<URLRouting.Rest<Substring>,
//          Parser.Conversion.Map<Parser.Conversion.String,
//            Parser.Conversion.RawValue<Tagged<Stripe.Customers.Customer, String>>>>
//        → Parse<…> → RFC_3986.URI.Path.Builder.Component<…>
//
//  Root cause is incomplete `SuppressedAssociatedTypes` codegen on 6.3; the fix
//  travels with the 6.4 COMPILER BINARY. There is no 6.3.x source fix — a
//  library-level router workaround was already tried and REVERTED on correctness
//  grounds. The accepted resolution is AVOIDANCE.
//
//  The faulting witness tables belong to the `{id}` PATH components, whose
//  parsers close over `Tagged<…, String>`. A router is instantiated as a UNIT, so
//  `OneOf`-ing the `{id}` routes alongside `create` forces their path parsers even
//  when only `create` is ever printed. That is why merely CALLING `create` through
//  the generated router still crashes.
//
//  WHAT THIS IS
//  ------------
//  A create-only parser-printer over `Stripe.Customers.API`. Its route body is a
//  VERBATIM COPY of the `.create` branch of `Stripe.Customers.API.Router.body`
//  (`Stripe Customers Types API.swift`) — same `Method`, same `Path` literals, same
//  `Body(.form(…, decoder: .stripe, encoder: .stripe))` conversion over the same
//  request type. It therefore prints byte-identical request data; it simply omits
//  the `{id}` routes whose witness tables trip §A9.
//
//  WIRE-SHAPE IDENTITY is a copy-equality argument, not a reimplementation
//  argument: nothing downstream is duplicated. The base-URL merge, the
//  `Authorization` / `Stripe-Version` / `Content-Type` header injection, and the
//  `URLRequestData → URLRequest` bridge are the SAME shared code the generated
//  router runs through (`baseRequestData(_:).request(for:)`).
//
//  AT THE 6.4 FLIP
//  ---------------
//  Delete this file and its sibling
//  `Stripe Checkout Sessions Types API.Router.Compat_Swift_6_3.swift`, delete the
//  `Compat_Swift_6_3` consumers in swift-stripe-live, and drop the composition-root
//  registrations in the consuming app. Grep token: `Compat_Swift_6_3`.
//  Catalog: swift-institute/Research/swift-compiler-bug-catalog.md §A9.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Customers.API.Router {
    /// 6.3.x-compat (§A9) create-only router — see the file header.
    ///
    /// Prints `POST /v1/customers` with a `.stripe`-encoded form body, exactly as
    /// ``Stripe/Customers/API/Router`` does for ``Stripe/Customers/API/create(request:)``.
    /// Printing any other route throws — the caller is expected to reject non-`create`
    /// routes with a named compat error before reaching this router.
    ///
    /// - Warning: 6.3.x-compat path, §A9-class. RETIRES-OR-REDISPOSES AT THE 6.4 FLIP.
    public struct Compat_Swift_6_3: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.API> {
            // ▼ VERBATIM COPY of Stripe.Customers.API.Router.body's `.create` branch.
            //   Keep in sync until the 6.4 flip deletes this type.
            URLRouting.Route(.case(Stripe.Customers.API.cases.create)) {
                Method.post
                Path.v1
                Path.customers
                URLRouting.Body(
                    .form(
                        Stripe.Customers.Create.Request.self,
                        decoder: .stripe,
                        encoder: .stripe
                    )
                )
            }
        }
    }
}
