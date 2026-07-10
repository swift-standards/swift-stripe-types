import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.CreditBalanceSummary {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/credit-balance-summary/retrieve.md
        case retrieve(request: Retrieve.Request)
    }
}

extension Stripe.Billing.CreditBalanceSummary.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.CreditBalanceSummary.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.CreditBalanceSummary.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_balance_summary
                    // Note: The filter parameter has complex nested structure that requires special handling
                    // filter[type] is required and determines which other filter fields are present
                    // This simplified implementation focuses on the customer parameter
                    // A full implementation would need custom query encoding for the nested filter structure
                    Query {
                        Field("customer") {
                            Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                        }
                        // TODO: Add proper filter handling with nested query parameters:
                        // - filter[type]: credit_grant or applicability_scope
                        // - filter[credit_grant]: string (when type is credit_grant)
                        // - filter[applicability_scope][price_type]: metered (when type is applicability_scope)
                        // - filter[applicability_scope][prices]: array of price IDs
                    }
                    .map(
                        .convert(
                            apply: { (customer: Stripe.Customers.Customer.ID) in
                                // Create with a default filter - in production this would parse the actual filter params
                                Stripe.Billing.CreditBalanceSummary.Retrieve.Request(
                                    customer: customer,
                                    filter: .init(type: .applicabilityScope)
                                )
                            },
                            unapply: { request in
                                // For now, only return the customer - full implementation would serialize filter
                                return request.customer
                            }
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    package static var credit_balance_summary: Path<PathBuilder.Component<String>> { Path { "credit_balance_summary" } }
}
