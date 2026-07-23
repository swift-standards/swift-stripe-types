//
//  Stripe Setup Attempts Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Setup.Attempts {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/setup_attempts/list.md
        case list(request: Stripe.Setup.Attempts.List.Request)
    }
}

extension Stripe.Setup.Attempts.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Setup.Attempts.API> {
            OneOf {
                // https://docs.stripe.com/api/setup_attempts/list.md
                URLRouting.Route(.case(Stripe.Setup.Attempts.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.setupAttempts
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Setup.Attempts.List.Request.init,
                                { ($0.setupIntent, $0.created, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("setup_intent") {
                                Parse(.string.representing(Stripe.Setup.Intent.ID.self))
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
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
    public static var setupAttempts: Path<PathBuilder.Component<String>> { Path {
        "setup_attempts"
    } }
}
