import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Products.Prices {
    @Cases
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
                URLRouting.Route(.case(Stripe.Products.Prices.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.prices
                    URLRouting.Body(
                        .form(
                            Stripe.Products.Prices.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Path { Parse(.string.representing(Stripe.Products.Price.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Products.Prices.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.prices
                    Path { Parse(.string.representing(Stripe.Products.Price.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Products.Prices.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Prices.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0.0.0.0, $0.0.0.0.0.0.0.0.0.1, $0.0.0.0.0.0.0.0.1, $0.0.0.0.0.0.0.1, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6), $0.7), $0.8), $0.9) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.Prices.List.Request.init,
                                { ($0.active, $0.currency, $0.created, $0.endingBefore, $0.limit, $0.lookupKeys, $0.product, $0.recurring, $0.startingAfter, $0.type) }
                            )
                        )
                    ) {
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
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("lookup_keys") {
                                    // swift-parsing `Many` dissolved onto the vended conversion seam:
                                    // parse wraps the whole field value as a single element; print joins
                                    // (identical to the original `Many { Parse(.string) }` degenerate
                                    // no-separator behavior over a field value).
                                    Parse(.string).map(.convert(apply: { [$0] }, unapply: { $0.joined() }))
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

                URLRouting.Route(.case(Stripe.Products.Prices.API.cases.search)) {
                    Method.get
                    Path.v1
                    Path.prices
                    Path { "search" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.Prices.Search.Request.init,
                                { ($0.query, $0.limit, $0.page) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Field("query") { Parse(.string) }
                            Optionally {
                                Field("limit") { Int.parser() }
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
