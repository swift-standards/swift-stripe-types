import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Capital {
    @Cases
    public enum API: Equatable, Sendable {
        case financingOffer(Stripe.Capital.FinancingOffer.API)
        case financingSummary(Stripe.Capital.FinancingSummary.API)
    }
}

extension Stripe.Capital.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Capital.API> {
            OneOf {
                Stripe.Capital.FinancingOffer.API.Router()
                    .map(.case(Stripe.Capital.API.cases.financingOffer))

                Stripe.Capital.FinancingSummary.API.Router()
                    .map(.case(Stripe.Capital.API.cases.financingSummary))
            }
        }
    }
}
