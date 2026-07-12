//
//  Stripe Events Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Events {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/events/retrieve.md
        case retrieve(id: Stripe.Events.Event.ID)
        // https://docs.stripe.com/api/events/list.md
        case list(request: Stripe.Events.List.Request)
    }
}

extension Stripe.Events.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Events.API> {
            OneOf {
                // https://docs.stripe.com/api/events/retrieve.md
                URLRouting.Route(.case(Stripe.Events.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.events
                    Path { Parse(.string.representing(Stripe.Events.Event.ID.self)) }
                }

                // https://docs.stripe.com/api/events/list.md
                URLRouting.Route(.case(Stripe.Events.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.events
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Events.List.Request.init,
                                { ($0.created, $0.deliverySuccess, $0.endingBefore, $0.limit, $0.startingAfter, $0.type, $0.types) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("delivery_success") { Bool.parser() }
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
                            Optionally {
                                Field("type") { Parse(.string) }
                            }

                            // types array is not parsed here - handled separately
                            // (pointfree `Always(value)` dissolved onto the vended constant pair:
                            // `Parser.Always` + `Parser.Conversion.Fixed`, per URI.Route's own spelling)
                            Parser.Always<RFC_3986.URI.Request.Fields, Void>(()).map(.fixed([String]?.none))

                            // TRIED BUT DOESNT WORK
                            //                            Optionally {
                            //                                Field("types") { Many { Parse(.string) } }
                            //                            }
                            //                            Optionally {
                            //                                Field("types") {
                            //                                    "["
                            //                                    Many {
                            //                                        Parse(.string)
                            //                                    } separator: {
                            //                                        ",".utf8
                            //                                    } terminator: {
                            //                                        "]".utf8
                            //                                    }
                            //                                }
                            //                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var events: Path<PathBuilder.Component<String>> { Path {
        "events"
    } }
}
