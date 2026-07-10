import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Products.Coupons {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/coupons/create.md
        case create(request: Stripe.Products.Coupons.Create.Request)
        // https://docs.stripe.com/api/coupons/update.md
        case update(id: Stripe.Products.Coupon.ID, request: Stripe.Products.Coupons.Update.Request)
        // https://docs.stripe.com/api/coupons/retrieve.md
        case retrieve(id: Stripe.Products.Coupon.ID)
        // https://docs.stripe.com/api/coupons/list.md
        case list(request: Stripe.Products.Coupons.List.Request)
        // https://docs.stripe.com/api/coupons/delete.md
        case delete(id: Stripe.Products.Coupon.ID)
    }
}

extension Stripe.Products.Coupons.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.Coupons.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Products.Coupons.API.create)) {
                    Method.post
                    Path.v1
                    Path.coupons
                    Body(
                        .form(
                            Stripe.Products.Coupons.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Coupons.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.coupons
                    Path { Parse(.string.representing(Stripe.Products.Coupon.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Products.Coupons.API.update)) {
                    Method.post
                    Path.v1
                    Path.coupons
                    Path { Parse(.string.representing(Stripe.Products.Coupon.ID.self)) }
                    Body(
                        .form(
                            Stripe.Products.Coupons.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Coupons.API.list)) {
                    Method.get
                    Path.v1
                    Path.coupons
                    Parse(.memberwise(Stripe.Products.Coupons.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
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

                URLRouting.Route(.case(Stripe.Products.Coupons.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.coupons
                    Path { Parse(.string.representing(Stripe.Products.Coupon.ID.self)) }
                }
            }
        }
    }
}

// Add path extensions for Coupons
extension Path<PathBuilder.Component<String>> {
    public static var coupons: Path<PathBuilder.Component<String>> { Path {
        "coupons"
    } }
}
