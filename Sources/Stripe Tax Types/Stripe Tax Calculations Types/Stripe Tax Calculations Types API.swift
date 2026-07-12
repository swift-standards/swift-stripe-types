//
//  Stripe Tax Calculations Types API.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Tax.Calculations {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/tax/calculations/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/tax/calculations/retrieve.md
        case retrieve(id: Stripe.Tax.Calculation.ID)
        // https://docs.stripe.com/api/tax/calculations/line_items.md
        case listLineItems(id: Stripe.Tax.Calculation.ID, request: List.LineItems.Request)
    }
}

extension Stripe.Tax.Calculations.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Tax.Calculations.API> {
            OneOf {
                Route(.case(Stripe.Tax.Calculations.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.tax
                    Path.calculations
                    URLRouting.Body(
                        .form(
                            Stripe.Tax.Calculations.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Tax.Calculations.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.tax
                    Path.calculations
                    Path { Parse(.string.representing(Stripe.Tax.Calculation.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Tax.Calculations.API.cases.listLineItems))) {
                    Method.get
                    Path.v1
                    Path.tax
                    Path.calculations
                    Path { Parse(.string.representing(Stripe.Tax.Calculation.ID.self)) }
                    Path.lineItems
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Tax.Calculations.List.LineItems.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
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
    public static var tax: Path<PathBuilder.Component<String>> { Path {
        "tax"
    } }

    public static var calculations: Path<PathBuilder.Component<String>> { Path {
        "calculations"
    } }

    public static var lineItems: Path<PathBuilder.Component<String>> { Path {
        "line_items"
    } }
}
