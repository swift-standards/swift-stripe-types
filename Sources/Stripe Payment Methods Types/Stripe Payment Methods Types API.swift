import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.PaymentMethods {
    @Cases
    public enum API: Equatable, Sendable {
        case paymentMethods(Stripe.PaymentMethods.PaymentMethods.API)
        case paymentMethodConfigurations(Stripe.PaymentMethodConfigurations.API)
        case paymentMethodDomains(Stripe.PaymentMethodDomains.API)
        case sources(Stripe.PaymentMethods.Sources.API)
    }
}

extension Stripe.PaymentMethods.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentMethods.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.PaymentMethods.API.cases.paymentMethods)) {
                    Stripe.PaymentMethods.PaymentMethods.API.Router()
                }

                URLRouting.Route(.case(Stripe.PaymentMethods.API.cases.paymentMethodConfigurations)) {
                    Stripe.PaymentMethodConfigurations.API.Router()
                }

                URLRouting.Route(.case(Stripe.PaymentMethods.API.cases.paymentMethodDomains)) {
                    Stripe.PaymentMethodDomains.API.Router()
                }

                URLRouting.Route(.case(Stripe.PaymentMethods.API.cases.sources)) {
                    Stripe.PaymentMethods.Sources.API.Router()
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var paymentMethods: Path<PathBuilder.Component<String>> { Path {
        "payment_methods"
    } }
}
