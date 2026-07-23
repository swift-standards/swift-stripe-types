import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Checkout.Sessions {
    @Cases
    public enum API: Equatable, Sendable {
        case create(request: Stripe.Checkout.Sessions.Create.Request)
        case update(
            id: Stripe.Checkout.Session.ID,
            request: Stripe.Checkout.Sessions.Update.Request
        )
        case retrieve(id: Stripe.Checkout.Session.ID)
        case list(request: Stripe.Checkout.Sessions.List.Request)
        case expire(id: Stripe.Checkout.Session.ID)
        case lineItems(
            id: Stripe.Checkout.Session.ID,
            request: Stripe.Checkout.Sessions.LineItems.Request
        )
    }
}

extension Stripe.Checkout.Sessions.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Checkout.Sessions.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    URLRouting.Body(
                        .form(
                            Stripe.Checkout.Sessions.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Checkout.Sessions.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Checkout.Sessions.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Checkout.Sessions.List.Request.init,
                                { ($0.paymentIntent, $0.subscription, $0.startingAfter, $0.endingBefore, $0.limit) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("payment_intent") {
                                    Parse(
                                        .string.representing(
                                            Stripe.PaymentIntents.PaymentIntent.ID.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("subscription") {
                                    Parse(.string.representing(Stripe.Billing.Subscription.ID.self))
                                }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.cases.expire)) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    Path { "expire" }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Checkout.Sessions.API.cases.lineItems))) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    Path { "line_items" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Checkout.Sessions.LineItems.Request.init,
                                { ($0.endingBefore, $0.startingAfter, $0.limit) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Add path extensions for Sessions
extension Path<PathBuilder.Component<String>> {
    public static var sessions: Path<PathBuilder.Component<String>> { Path {
        "sessions"
    } }

    public static var checkout: Path<PathBuilder.Component<String>> { Path {
        "checkout"
    } }
}
