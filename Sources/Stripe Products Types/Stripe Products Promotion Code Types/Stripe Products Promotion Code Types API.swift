import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Products.PromotionCodes {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/promotion_codes/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/promotion_codes/retrieve.md
        case retrieve(id: Promotion.Code.ID)
        // https://docs.stripe.com/api/promotion_codes/update.md
        case update(id: Promotion.Code.ID, request: Update.Request)
        // https://docs.stripe.com/api/promotion_codes/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Products.PromotionCodes.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.PromotionCodes.API> {
            OneOf {
                Route(.case(Stripe.Products.PromotionCodes.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.promotionCodes
                    URLRouting.Body(
                        .form(
                            Stripe.Products.PromotionCodes.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.PromotionCodes.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.promotionCodes
                    Path { Parse(.string.representing(Promotion.Code.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Products.PromotionCodes.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.promotionCodes
                    Path { Parse(.string.representing(Promotion.Code.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Products.PromotionCodes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.PromotionCodes.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.promotionCodes
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0.0, $0.0.0.0.0.0.0.1, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6), $0.7) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.PromotionCodes.List.Request.init,
                                { ($0.active, $0.code, $0.coupon, $0.created, $0.customer, $0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("active") { Bool.parser() }
                            }
                            Optionally {
                                Field("code") { Parse(.string) }
                            }
                            Optionally {
                                Field("coupon") {
                                    Parse(.string.representing(Stripe.Products.Coupon.ID.self))
                                }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
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
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var promotionCodes: Path<PathBuilder.Component<String>> { Path {
        "promotion_codes"
    } }
}
