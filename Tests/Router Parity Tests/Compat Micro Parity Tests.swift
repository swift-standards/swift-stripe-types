//
//  Compat Micro Parity Tests.swift
//  swift-stripe-types
//
//  Batch-0 stripe micro-corpus (plan v1.4.0 §Stripe carve-out): the TWO
//  production compat branches — the only Stripe routes that print on 6.3.x.
//  These run UNGATED (production exercises them daily); the full-router suite
//  stays behind the §A9 gate until the flip.
//

import Foundation
import Testing
import URL_Routing_Test_Support

@testable import Stripe_Customers_Types
@testable import Stripe_Checkout_Types

@Suite("Compat Micro Parity")
struct CompatMicroParity {

    @Test
    func `customers create via Compat_Swift_6_3 prints stably`() throws {
        let router = Stripe.Customers.API.Router.Compat_Swift_6_3()
        let request = Stripe.Customers.Create.Request(
            description: "parity fixture customer",
            email: "parity@example.com",
            name: "Parity Fixture"
        )
        let corpus = try Parity.corpus(
            of: [("customers.create", Stripe.Customers.API.create(request: request))],
            via: router
        )
        try assertParity(corpus, fixture: "Compat.Customers")
    }

    @Test
    func `checkout sessions create via Compat_Swift_6_3 prints stably`() throws {
        let router = Stripe.Checkout.Sessions.API.Router.Compat_Swift_6_3()
        let request = Stripe.Checkout.Sessions.Create.Request(
            successUrl: "https://example.com/success",
            cancelUrl: "https://example.com/cancel",
            clientReferenceId: "parity-fixture-1",
            mode: .payment
        )
        let corpus = try Parity.corpus(
            of: [("checkout.sessions.create", Stripe.Checkout.Sessions.API.create(request: request))],
            via: router
        )
        try assertParity(corpus, fixture: "Compat.CheckoutSessions")
    }
}
