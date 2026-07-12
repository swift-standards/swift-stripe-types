import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting
import URLRouting

extension Stripe.Fraud.Reviews {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/radar/reviews/retrieve.md
        case retrieve(id: Review.ID)
        // https://docs.stripe.com/api/radar/reviews/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/radar/reviews/approve.md
        case approve(id: Review.ID, request: Approve.Request)
    }
}

extension Stripe.Fraud.Reviews.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Fraud.Reviews.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Fraud.Reviews.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path { "reviews" }
                    Path { Parse(.string.representing(Stripe.Fraud.Reviews.Review.ID.self)) }
                }

                //                URLRouting.Route(.case(Stripe.Fraud.Reviews.API.list)) {
                //                    Method.get
                //                    Path.v1
                //                    Path { "reviews" }
                //                    Query {
                //                        Optionally {
                //                            Field("ending_before") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("limit") { Int.parser() }
                //                        }
                //                        Optionally {
                //                            Field("starting_after") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("created", .inlineArray) { Stripe.DateFilter.queryParser() }
                //                        }
                //                    }
                //                    .query(Stripe.Fraud.Reviews.API.List.Request?.self)
                //                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Fraud.Reviews.API.cases.approve))) {
                    Method.post
                    Path.v1
                    Path { "reviews" }
                    Path { Parse(.string.representing(Stripe.Fraud.Reviews.Review.ID.self)) }
                    Path.approve
                    URLRouting.Body(
                        .form(
                            Stripe.Fraud.Reviews.API.Approve.Request.self,
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
    public static var reviews: Path<PathBuilder.Component<String>> { Path {
        "reviews"
    } }

    public static var approve: Path<PathBuilder.Component<String>> { Path {
        "approve"
    } }
}
