//
//  Stripe Billing Plans Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Billing.Plans {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/plans/create.md
        case create(request: Stripe.Billing.Plans.Create.Request)
        // https://docs.stripe.com/api/plans/retrieve.md
        case retrieve(id: Stripe.Billing.Plan.ID)
        // https://docs.stripe.com/api/plans/update.md
        case update(id: Stripe.Billing.Plan.ID, request: Stripe.Billing.Plans.Update.Request)
        // https://docs.stripe.com/api/plans/list.md
        case list(request: Stripe.Billing.Plans.List.Request)
        // https://docs.stripe.com/api/plans/delete.md
        case delete(id: Stripe.Billing.Plan.ID)
    }
}

extension Stripe.Billing.Plans.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Plans.API> {
            OneOf {
                // https://docs.stripe.com/api/plans/create.md
                URLRouting.Route(.case(Stripe.Billing.Plans.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.plans
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Plans.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/plans/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.Plans.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.plans
                    Path { Parse(.string.representing(Stripe.Billing.Plan.ID.self)) }
                }

                // https://docs.stripe.com/api/plans/update.md
                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Plans.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.plans
                    Path { Parse(.string.representing(Stripe.Billing.Plan.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Plans.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/plans/list.md
                URLRouting.Route(.case(Stripe.Billing.Plans.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.plans
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Plans.List.Request.init,
                                { ($0.active, $0.created, $0.endingBefore, $0.limit, $0.product, $0.startingAfter) }
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
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("product") {
                                    Parse(.string.representing(Stripe.Products.Product.ID.self))
                                }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/plans/delete.md
                URLRouting.Route(.case(Stripe.Billing.Plans.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.plans
                    Path { Parse(.string.representing(Stripe.Billing.Plan.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var plans: Path<PathBuilder.Component<String>> { Path {
        "plans"
    } }
}
