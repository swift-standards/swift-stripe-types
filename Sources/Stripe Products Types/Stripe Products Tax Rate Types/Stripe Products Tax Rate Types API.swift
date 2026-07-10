import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Products.TaxRates {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.Products.TaxRates.API.create)) {
                    Method.post
                    Path.v1
                    Path.taxRates
                    Body(
                        .form(
                            Stripe.Products.TaxRates.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.TaxRates.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.taxRates
                    Path { Parse(.string.representing(Stripe.Tax.Rate.ID.self)) }
                }

                Route(.case(Stripe.Products.TaxRates.API.update)) {
                    Method.post
                    Path.v1
                    Path.taxRates
                    Path { Parse(.string.representing(Stripe.Tax.Rate.ID.self)) }
                    Body(
                        .form(
                            Stripe.Products.TaxRates.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Products.TaxRates.API.list)) {
                    Method.get
                    Path.v1
                    Path.taxRates
                    Parse(.memberwise(Stripe.Products.TaxRates.List.Request.init)) {
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
    public static var taxRates: Path<PathBuilder.Component<String>> { Path {
        "tax_rates"
    } }
}
