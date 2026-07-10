//
//  Stripe Billing Meter Event Summary Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.MeterEventSummary {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.Billing.MeterEventSummary.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.meters
                    Path { Parse(.string) }
                    Path.event_summaries
                    Parse(.memberwise(Stripe.Billing.MeterEventSummary.List.Request.init)) {
                        Query {
                            Field("customer") {
                                Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                            }
                            Field("start_time") { Digits() }
                            Field("end_time") { Digits() }
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
                                Field("limit") { Digits() }
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
