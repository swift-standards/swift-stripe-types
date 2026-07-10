import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.WebhookEndpoint {
    public typealias ID = Tagged<Self, String>
}

extension Stripe.WebhookEndpoint {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.WebhookEndpoint.API.create)) {
                    Method.post
                    Path.v1
                    Path.webhookEndpoints
                    Body(
                        .form(
                            Stripe.WebhookEndpoint.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.WebhookEndpoint.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.webhookEndpoints
                    Path { Parse(.string.representing(Stripe.WebhookEndpoint.ID.self)) }
                }

                Route(.case(Stripe.WebhookEndpoint.API.update)) {
                    Method.post
                    Path.v1
                    Path.webhookEndpoints
                    Path { Parse(.string.representing(Stripe.WebhookEndpoint.ID.self)) }
                    Body(
                        .form(
                            Stripe.WebhookEndpoint.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.WebhookEndpoint.API.list)) {
                    Method.get
                    Path.v1
                    Path.webhookEndpoints
                    Parse(.memberwise(Stripe.WebhookEndpoint.List.Request.init)) {
                        Query {
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

                Route(.case(Stripe.WebhookEndpoint.API.delete)) {
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
