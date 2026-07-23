import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Customers.CashBalance {
    @Cases
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
                Route(.case(Stripe.Customers.CashBalance.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalance
                }

                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.CashBalance.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cashBalance
                    URLRouting.Body(
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
