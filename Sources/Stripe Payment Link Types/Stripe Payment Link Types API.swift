import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.PaymentLinks {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.PaymentLinks.API.create)) {
                    Method.post
                    Path.v1
                    Path.paymentLinks
                    Body(
                        .form(
                            Stripe.PaymentLinks.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment-link/update.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.update)) {
                    Method.post
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                    Body(
                        .form(
                            Stripe.PaymentLinks.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/payment-link/retrieve.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                }

                // https://docs.stripe.com/api/payment-link/list.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.list)) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Parse(.memberwise(Stripe.PaymentLinks.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("active") { Bool.parser() }
                            }
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

                // https://docs.stripe.com/api/payment-link/retrieve-line-items.md
                URLRouting.Route(.case(Stripe.PaymentLinks.API.lineItems)) {
                    Method.get
                    Path.v1
                    Path.paymentLinks
                    Path { Parse(.string.representing(Stripe.PaymentLink.ID.self)) }
                    Path { "line_items" }
                    Parse(.memberwise(Stripe.PaymentLinks.LineItems.Request.init)) {
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

extension Path<PathBuilder.Component<String>> {
    public static var paymentLinks: Path<PathBuilder.Component<String>> { Path {
        "payment_links"
    } }
}
