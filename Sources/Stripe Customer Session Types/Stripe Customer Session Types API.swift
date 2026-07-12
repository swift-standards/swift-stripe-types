import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Customers.Customer.Sessions {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/customer_sessions/create.md
        case create(request: Stripe.Customers.Customer.Sessions.Create.Request)
    }
}

extension Stripe.Customers.Customer.Sessions.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.Customer.Sessions.API> {
            OneOf {
                // https://docs.stripe.com/api/customer_sessions/create.md
                URLRouting.Route(.case(Stripe.Customers.Customer.Sessions.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.customerSessions
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.Customer.Sessions.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

// Add path extensions for Customer Sessions
extension Path<PathBuilder.Component<String>> {
    public static var customerSessions: Path<PathBuilder.Component<String>> { Path {
        "customer_sessions"
    } }
}
