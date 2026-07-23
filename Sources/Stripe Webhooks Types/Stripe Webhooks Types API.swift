import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Webhooks {
    @Cases
    public enum API: Equatable, Sendable {
        case webhookEndpoint(Stripe.WebhookEndpoint.API)
    }
}

extension Stripe.Webhooks.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Webhooks.API> {
            OneOf {
                Stripe.WebhookEndpoint.API.Router()
                    .map(.case(Stripe.Webhooks.API.cases.webhookEndpoint))
            }
        }
    }
}
