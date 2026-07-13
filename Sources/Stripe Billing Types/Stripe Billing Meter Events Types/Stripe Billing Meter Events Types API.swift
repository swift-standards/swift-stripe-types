//
//  Stripe Billing Meter Events Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Billing.MeterEvents {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/meter-event/create.md
        case create(request: Create.Request)
    }
}

extension Stripe.Billing.MeterEvents.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.MeterEvents.API> {
            OneOf {
                Route(.case(Stripe.Billing.MeterEvents.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.meter_events
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.MeterEvents.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var meter_events: Path<PathBuilder.Component<String>> { Path {
        "meter_events"
    } }
}
