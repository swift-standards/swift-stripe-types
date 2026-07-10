import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Capital.FinancingSummary {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/capital/financing_summary/retrieve.md
        case retrieve
    }
}

extension Stripe.Capital.FinancingSummary.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Capital.FinancingSummary.API> {
            OneOf {
                Route(.case(Stripe.Capital.FinancingSummary.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.capital
                    Path.financingSummary
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var financingSummary: Path<PathBuilder.Component<String>> { Path {
        "financing_summary"
    } }
}
