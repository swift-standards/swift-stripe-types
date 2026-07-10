import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Products.Prices {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case create(request: Stripe.Products.Prices.Create.Request)
        case update(id: Stripe.Products.Price.ID, request: Stripe.Products.Prices.Update.Request)
        case retrieve(id: Stripe.Products.Price.ID)
        case list(request: Stripe.Products.Prices.List.Request)
        case search(request: Stripe.Products.Prices.Search.Request)
    }
}

extension Stripe.Products.Prices.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.Prices.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Products.Prices.API.create)) {
                    Method.post
                    Path.v1
                    Path.prices
                    Body(
                        .form(
                            Stripe.Products.Prices.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Path { Parse(.string.representing(Stripe.Products.Price.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.update)) {
                    Method.post
                    Path.v1
                    Path.prices
                    Path { Parse(.string.representing(Stripe.Products.Price.ID.self)) }
                    Body(
                        .form(
                            Stripe.Products.Prices.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.list)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Parse(.memberwise(Stripe.Products.Prices.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("active") { Bool.parser() }
                            }
                            Optionally {
                                Field("currency") {
                                    Parse(.string.representing(Stripe.Currency.self))
                                }
                            }
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
                                Field("lookup_keys") {
                                    Many {
                                        Parse(.string)
                                    }
                                }
                            }
                            Optionally {
                                Field("product") {
                                    Parse(.string.representing(Stripe.Products.Product.ID.self))
                                }
                            }
                            Optionally {
                                Field("recurring") { Parse(.string) }  // Recurring.Filter as string
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("type") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.search)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Path { "search" }
                    Parse(.memberwise(Stripe.Products.Prices.Search.Request.init)) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("page") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Add path extensions for Prices
extension Path<PathBuilder.Component<String>> {
    public static var prices: Path<PathBuilder.Component<String>> { Path {
        "prices"
    } }
}
