import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Checkout.Sessions {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.create)) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Body(
                        .form(
                            Stripe.Checkout.Sessions.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.update)) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    Body(
                        .form(
                            Stripe.Checkout.Sessions.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.list)) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Parse(.memberwise(Stripe.Checkout.Sessions.List.Request.init)) {
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
                                Field("limit") { Digits() }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.expire)) {
                    Method.post
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    Path { "expire" }
                }

                URLRouting.Route(.case(Stripe.Checkout.Sessions.API.lineItems)) {
                    Method.get
                    Path.v1
                    Path.checkout
                    Path.sessions
                    Path { Parse(.string.representing(Stripe.Checkout.Session.ID.self)) }
                    Path { "line_items" }
                    Parse(.memberwise(Stripe.Checkout.Sessions.LineItems.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
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
