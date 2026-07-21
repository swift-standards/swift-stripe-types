//
//  Charges Parity Tests.swift
//  swift-stripe-types
//

import Foundation
import Stripe_Charges_Types
import Stripe_Types_Models
import Stripe_Types_Shared
import Testing
import URL_Routing_Test_Support

@Suite(
    "Charges Parity",
    .disabled(if: taggedMetadataSIGSEGV, "catalog §A9: Tagged metadata SIGSEGV on Swift <6.4")
)
struct ChargesParity {
    @Test func corpus() throws {
        let router = Stripe.Charges.API.Router()
        let chargeID = try #require(Stripe.Charges.Charge.ID(rawValue: "ch_123"))
        let routes: [(name: String, route: Stripe.Charges.API)] = [
            (
                "create",
                .create(
                    request: .init(
                        amount: 2000,
                        currency: .usd,
                        customer: "cus_123",
                        description: "Parity charge",
                        metadata: ["order_id": "12345"]
                    )
                )
            ),
            ("retrieve", .retrieve(id: chargeID)),
            (
                "update",
                .update(
                    id: chargeID,
                    request: .init(description: "Updated", metadata: ["k": "v"])
                )
            ),
            ("list", .list(request: .init(customer: "cus_123", limit: 3))),
            (
                "capture",
                .capture(id: chargeID, request: .init(amount: 1500))
            ),
            ("search", .search(request: .init(query: "amount>999", limit: 2)))
        ]
        try assertParity(try Parity.corpus(of: routes, via: router), fixture: "Charges")
        for (_, route) in routes {
            #expect(try Parity.roundTrips(route, via: router))
        }
    }
}
