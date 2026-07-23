import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Capital.FinancingSummary {
    @Cases
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
                Route(.case(Stripe.Capital.FinancingSummary.API.cases.retrieve)) {
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
