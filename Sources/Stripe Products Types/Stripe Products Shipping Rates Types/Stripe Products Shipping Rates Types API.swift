import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Products.ShippingRates {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/shipping_rates/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/shipping_rates/retrieve.md
        case retrieve(id: Stripe.Products.Shipping.Rate.ID)
        // https://docs.stripe.com/api/shipping_rates/update.md
        case update(id: Stripe.Products.Shipping.Rate.ID, request: Update.Request)
        // https://docs.stripe.com/api/shipping_rates/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Products.ShippingRates.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.ShippingRates.API> {
            OneOf {
                Route(.case(Stripe.Products.ShippingRates.API.create)) {
                    Method.post
                    Path.v1
                    Path.shippingRates
                    Body(
                        .form(
                            Stripe.Products.ShippingRates.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.ShippingRates.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.shippingRates
                    Path { Parse(.string.representing(Stripe.Products.Shipping.Rate.ID.self)) }
                }

                Route(.case(Stripe.Products.ShippingRates.API.update)) {
                    Method.post
                    Path.v1
                    Path.shippingRates
                    Path { Parse(.string.representing(Stripe.Products.Shipping.Rate.ID.self)) }
                    Body(
                        .form(
                            Stripe.Products.ShippingRates.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.ShippingRates.API.list)) {
                    Method.get
                    Path.v1
                    Path.shippingRates
                    Parse(.memberwise(Stripe.Products.ShippingRates.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("active") { Bool.parser() }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("currency") {
                                    Parse(.string.representing(Stripe.Currency.self))
                                }
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
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var shippingRates: Path<PathBuilder.Component<String>> { Path {
        "shipping_rates"
    } }
}
