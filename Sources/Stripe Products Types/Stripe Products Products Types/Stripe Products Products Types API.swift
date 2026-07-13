//
//  Products API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.Products.Products {
    @Cases
    public enum API: Equatable, Sendable {
        case create(request: Stripe.Products.Products.Create.Request)
        case update(
            id: Stripe.Products.Product.ID,
            request: Stripe.Products.Products.Update.Request
        )
        case retrieve(id: Stripe.Products.Product.ID)
        case list(request: Stripe.Products.Products.List.Request)
        case delete(id: Stripe.Products.Product.ID)
        case search(request: Stripe.Products.Products.Search.Request)
    }
}

extension Stripe.Products.Products.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.Products.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Products.Products.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.products
                    URLRouting.Body(
                        .form(
                            Stripe.Products.Products.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Products.Products.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Products.Products.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.products
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0.0.0.0, $0.0.0.0.0.0.0.0.1, $0.0.0.0.0.0.0.1, $0.0.0.0.0.0.1, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5), $0.6), $0.7), $0.8) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.Products.List.Request.init,
                                { ($0.active, $0.created, $0.endingBefore, $0.ids, $0.limit, $0.shippable, $0.startingAfter, $0.type, $0.url) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("active") { Bool.parser() }
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
                                Field("ids") {
                                    // swift-parsing `Many` dissolved onto the vended conversion seam:
                                    // parse wraps the whole field value as a single element; print joins
                                    // (identical to the original `Many { Parse(.string) }` degenerate
                                    // no-separator behavior over a field value).
                                    Parse(.string).map(.convert(apply: { [$0] }, unapply: { $0.joined() }))
                                }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("shippable") { Bool.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("type") { Parse(.string) }
                            }
                            Optionally {
                                Field("url") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.cases.search)) {
                    Method.get
                    Path.v1
                    Path.products
                    Path { "search" }
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.Products.Search.Request.init,
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

extension Path<PathBuilder.Component<String>> {
    package static var products: Path<PathBuilder.Component<String>> { Path { "products" } }
}
