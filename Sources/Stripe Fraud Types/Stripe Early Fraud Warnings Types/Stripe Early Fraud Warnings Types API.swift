import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting
import URLRouting

extension Stripe.Fraud.EarlyFraudWarnings {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/radar/early_fraud_warnings/retrieve.md
        case retrieve(id: EarlyFraudWarning.ID)
        // https://docs.stripe.com/api/radar/early_fraud_warnings/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Fraud.EarlyFraudWarnings.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Fraud.EarlyFraudWarnings.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Fraud.EarlyFraudWarnings.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.radar
                    Path.earlyFraudWarnings
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning.ID.self
                            )
                        )
                    }
                }

                //                URLRouting.Route(.case(Stripe.Fraud.EarlyFraudWarnings.API.list)) {
                //                    Method.get
                //                    Path.v1
                //                    Path.radar
                //                    Path.earlyFraudWarnings
                //                    Query {
                //                        Optionally {
                //                            Field("charge") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("payment_intent") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("ending_before") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("limit") { Int.parser() }
                //                        }
                //                        Optionally {
                //                            Field("starting_after") { Parse(.string) }
                //                        }
                //                    }
                //                    .query(Stripe.Fraud.EarlyFraudWarnings.API.List.Request?.self)
                //                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var radar: Path<PathBuilder.Component<String>> { Path {
        "radar"
    } }

    public static var earlyFraudWarnings: Path<PathBuilder.Component<String>> { Path {
        "early_fraud_warnings"
    } }
}
