import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Forwarding.Request {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/forwarding/request/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/forwarding/request/retrieve.md
        case retrieve(id: Stripe.Forwarding.Request.ID)
        // https://docs.stripe.com/api/forwarding/request/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Forwarding.Request.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Forwarding.Request.API> {
            OneOf {
                Route(.case(Stripe.Forwarding.Request.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.forwarding
                    Path.requests
                    URLRouting.Body(
                        .form(
                            Stripe.Forwarding.Request.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Forwarding.Request.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.forwarding
                    Path.requests
                    Path { Parse(.string.representing(Stripe.Forwarding.Request.ID.self)) }
                }
                //                TODO
                //                Route(.case(Stripe.Forwarding.Request.API.list)) {
                //                    Method.get
                //                    Path.v1
                //                    Path.forwarding
                //                    Path.requests
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
                //                    }
                //                    .query(Stripe.Forwarding.Request.List.Request?.self)
                //                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var forwarding: Path<PathBuilder.Component<String>> { Path {
        "forwarding"
    } }

    public static var requests: Path<PathBuilder.Component<String>> { Path {
        "requests"
    } }
}
