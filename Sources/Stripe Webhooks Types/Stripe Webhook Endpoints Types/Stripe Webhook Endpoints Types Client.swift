import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.WebhookEndpoint {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/webhook_endpoints/create.md
        public var create:
            @Sendable (_ request: Stripe.WebhookEndpoint.Create.Request) async throws(any Swift.Error) -> Webhook

        // https://docs.stripe.com/api/webhook_endpoints/retrieve.md
        public var retrieve: @Sendable (_ id: Stripe.WebhookEndpoint.ID) async throws(any Swift.Error) -> Webhook

        // https://docs.stripe.com/api/webhook_endpoints/update.md
        public var update:
            @Sendable (
                _ id: Stripe.WebhookEndpoint.ID, _ request: Stripe.WebhookEndpoint.Update.Request
            )
                async throws(any Swift.Error) -> Webhook

        // https://docs.stripe.com/api/webhook_endpoints/list.md
        public var list:
            @Sendable (_ request: Stripe.WebhookEndpoint.List.Request) async throws(any Swift.Error) -> List.Response

        // https://docs.stripe.com/api/webhook_endpoints/delete.md
        public var delete:
            @Sendable (_ id: Stripe.WebhookEndpoint.ID) async throws(any Swift.Error) -> DeletedObject<
                Stripe.WebhookEndpoint
            >
    }
}
