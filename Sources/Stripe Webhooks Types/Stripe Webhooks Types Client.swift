import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Webhooks {
    public struct Client: Sendable {
        public var webhookEndpoint: Stripe.WebhookEndpoint.Client

        public init(
            webhookEndpoint: Stripe.WebhookEndpoint.Client = .unimplemented()
        ) {
            self.webhookEndpoint = webhookEndpoint
        }
    }
}
