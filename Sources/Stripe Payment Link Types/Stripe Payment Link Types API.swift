import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.PaymentLinks {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payment-link/create.md
        case create(request: Stripe.PaymentLinks.Create.Request)
        // https://docs.stripe.com/api/payment-link/update.md
        case update(id: Stripe.PaymentLink.ID, request: Stripe.PaymentLinks.Update.Request)
        // https://docs.stripe.com/api/payment-link/retrieve.md
        case retrieve(id: Stripe.PaymentLink.ID)
        // https://docs.stripe.com/api/payment-link/list.md
        case list(request: Stripe.PaymentLinks.List.Request)
        // https://docs.stripe.com/api/payment-link/retrieve-line-items.md
        case lineItems(id: Stripe.PaymentLink.ID, request: Stripe.PaymentLinks.LineItems.Request)
    }
}

extension Stripe.PaymentLinks.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentLinks.API> {
            OneOf {
                // https://docs.stripe.com/api/payment-link/create.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.paymentLinks
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentLinks.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment-link/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.PaymentLinks.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentLinks.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment-link/retrieve.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                }

                // https://docs.stripe.com/api/payment-link/list.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((($0.0, $0.1), $0.2), $0.3) }
                        )
                        .map(
                            .memberwise(
                                Stripe.PaymentLinks.List.Request.init,
                                { ($0.active, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("active") { Bool.parser() }
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

                // https://docs.stripe.com/api/payment-link/retrieve-line-items.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.PaymentLinks.API.cases.lineItems))) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                    Path { "line_items" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.PaymentLinks.LineItems.Request.init,
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

extension Path<PathBuilder.Component<String>> {
    public static var paymentLinks: Path<PathBuilder.Component<String>> { Path {
        "payment_links"
    } }
}
