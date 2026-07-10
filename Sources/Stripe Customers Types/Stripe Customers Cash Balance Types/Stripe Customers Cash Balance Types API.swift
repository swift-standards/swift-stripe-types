import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Customers.CashBalance {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/cash_balance/retrieve.md
        case retrieve(customerId: Stripe.Customers.Customer.ID)
        // https://docs.stripe.com/api/cash_balance/update.md
        case update(customerId: Stripe.Customers.Customer.ID, request: Update.Request)
    }
}

extension Stripe.Customers.CashBalance.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.CashBalance.API> {
            OneOf {
                Route(.case(Stripe.Customers.CashBalance.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalance
                }

                Route(.case(Stripe.Customers.CashBalance.API.update)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalance
                    Body(
                        .form(
                            Stripe.Customers.CashBalance.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var cashBalance: Path<PathBuilder.Component<String>> { Path {
        "cash_balance"
    } }
}
