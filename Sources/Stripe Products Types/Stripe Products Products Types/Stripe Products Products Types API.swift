//
//  Products API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Products.Products {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Products.Products.API.create)) {
                    Method.post
                    Path.v1
                    Path.products
                    Body(
                        .form(
                            Stripe.Products.Products.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.update)) {
                    Method.post
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                    Body(
                        .form(
                            Stripe.Products.Products.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.list)) {
                    Method.get
                    Path.v1
                    Path.products
                    Parse(.memberwise(Stripe.Products.Products.List.Request.init)) {
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
                                    Many {
                                        Parse(.string)
                                    }
                                }
                            }
                            Optionally {
                                Field("limit") { Digits() }
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

                URLRouting.Route(.case(Stripe.Products.Products.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.products
                    Path { Parse(.string.representing(Stripe.Products.Product.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Products.Products.API.search)) {
                    Method.get
                    Path.v1
                    Path.products
                    Path { "search" }
                    Parse(.memberwise(Stripe.Products.Products.Search.Request.init)) {
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

extension Path<PathBuilder.Component<String>> {
    package static var products: Path<PathBuilder.Component<String>> { Path { "products" } }
}
