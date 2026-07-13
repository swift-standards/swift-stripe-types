import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.Products.TaxRates {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/tax_rates/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/tax_rates/retrieve.md
        case retrieve(id: Stripe.Tax.Rate.ID)
        // https://docs.stripe.com/api/tax_rates/update.md
        case update(id: Stripe.Tax.Rate.ID, request: Update.Request)
        // https://docs.stripe.com/api/tax_rates/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Products.TaxRates.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Products.TaxRates.API> {
            OneOf {
                Route(.case(Stripe.Products.TaxRates.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.taxRates
                    URLRouting.Body(
                        .form(
                            Stripe.Products.TaxRates.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.TaxRates.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.taxRates
                    Path { Parse(.string.representing(Stripe.Tax.Rate.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Products.TaxRates.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.taxRates
                    Path { Parse(.string.representing(Stripe.Tax.Rate.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Products.TaxRates.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.TaxRates.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.taxRates
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Products.TaxRates.List.Request.init,
                                { ($0.active, $0.created, $0.endingBefore, $0.inclusive, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
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
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("inclusive") { Bool.parser() }
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
    public static var taxRates: Path<PathBuilder.Component<String>> { Path {
        "tax_rates"
    } }
}
