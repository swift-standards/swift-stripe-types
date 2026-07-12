import Stripe_Types_Shared
import URLRouting

/// API endpoints for Checkout
/// Documented at https://stripe.com/docs/api/checkout
extension Stripe.Checkout {
    @Cases
    public enum API: Equatable, Sendable {
        case sessions(Stripe.Checkout.Sessions.API)
    }
}

extension Stripe.Checkout.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Checkout.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Checkout.API.cases.sessions)) {
                    Stripe.Checkout.Sessions.API.Router()
                }
            }
        }
    }
}
