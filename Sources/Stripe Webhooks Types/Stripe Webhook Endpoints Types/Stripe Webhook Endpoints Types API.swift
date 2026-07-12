import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.WebhookEndpoint {
    public typealias ID = Tagged<Self, String>
}

extension Stripe.WebhookEndpoint {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/webhook_endpoints/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/webhook_endpoints/retrieve.md
        case retrieve(id: ID)
        // https://docs.stripe.com/api/webhook_endpoints/update.md
        case update(id: ID, request: Update.Request)
        // https://docs.stripe.com/api/webhook_endpoints/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/webhook_endpoints/delete.md
        case delete(id: ID)
    }
}

extension Stripe.WebhookEndpoint.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.WebhookEndpoint.API> {
            OneOf {
                Route(.case(Stripe.WebhookEndpoint.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.webhookEndpoints
                    URLRouting.Body(
                        .form(
                            Stripe.WebhookEndpoint.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.WebhookEndpoint.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.webhookEndpoints
                    Path { Parse(.string.representing(Stripe.WebhookEndpoint.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.WebhookEndpoint.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.webhookEndpoints
                    Path { Parse(.string.representing(Stripe.WebhookEndpoint.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.WebhookEndpoint.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.WebhookEndpoint.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.webhookEndpoints
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.WebhookEndpoint.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
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

                Route(.case(Stripe.WebhookEndpoint.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.webhookEndpoints
                    Path { Parse(.string.representing(Stripe.WebhookEndpoint.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var webhookEndpoints: Path<PathBuilder.Component<String>> { Path {
        "webhook_endpoints"
    } }
}
