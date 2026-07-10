import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Capital.FinancingOffer {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/capital/financing_offers/retrieve.md
        case retrieve(id: Stripe.Capital.FinancingOffer.ID)
        // https://docs.stripe.com/api/capital/financing_offers/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/capital/financing_offers/mark_delivered.md
        case markDelivered(id: Stripe.Capital.FinancingOffer.ID)
    }
}

extension Stripe.Capital.FinancingOffer.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Capital.FinancingOffer.API> {
            OneOf {
                Route(.case(Stripe.Capital.FinancingOffer.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.capital
                    Path.financingOffers
                    Path { Parse(.string.representing(Stripe.Capital.FinancingOffer.ID.self)) }
                }

                Route(.case(Stripe.Capital.FinancingOffer.API.list)) {
                    Method.get
                    Path.v1
                    Path.capital
                    Path.financingOffers
                    Parse(.memberwise(Stripe.Capital.FinancingOffer.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("connected_account") { Parse(.string) }
                            }
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("status") { Parse(.string) }
                            }
                            Field("limit", default: 10) { Digits() }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Capital.FinancingOffer.API.markDelivered)) {
                    Method.post
                    Path.v1
                    Path.capital
                    Path.financingOffers
                    Path { Parse(.string.representing(Stripe.Capital.FinancingOffer.ID.self)) }
                    Path.markDelivered
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var capital: Path<PathBuilder.Component<String>> { Path {
        "capital"
    } }
    public static var financingOffers: Path<PathBuilder.Component<String>> { Path {
        "financing_offers"
    } }
    public static var markDelivered: Path<PathBuilder.Component<String>> { Path {
        "mark_delivered"
    } }
}
