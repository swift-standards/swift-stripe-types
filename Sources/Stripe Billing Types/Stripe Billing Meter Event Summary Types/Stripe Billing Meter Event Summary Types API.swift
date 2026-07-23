//
//  Stripe Billing Meter Event Summary Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Billing.MeterEventSummary {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/meter-event-summary/list.md
        case list(meterId: String, request: List.Request)
    }
}

extension Stripe.Billing.MeterEventSummary.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.MeterEventSummary.API> {
            OneOf {
                Route(.convert(
                        apply: { (meterId: $0.0, request: $0.1) },
                        unapply: { ($0.meterId, $0.request) }
                    )
                    .map(.case(Stripe.Billing.MeterEventSummary.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string) }
                    Path.event_summaries
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.MeterEventSummary.List.Request.init,
                                { ($0.customer, $0.startTime, $0.endTime, $0.valueGroupingWindow, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
                            Field("customer") {
                                Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                            }
                            Field("start_time") { Int.parser() }
                            Field("end_time") { Int.parser() }
                            Optionally {
                                Field("value_grouping_window") {
                                    Parse(
                                        .string.representing(
                                            Stripe.Billing.MeterEventSummary.List.Request
                                                .ValueGroupingWindow.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var event_summaries: Path<PathBuilder.Component<String>> { Path {
        "event_summaries"
    } }
}
