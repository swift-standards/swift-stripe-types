import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Checkout.Sessions {
    @Witness
    public struct Client: Sendable {
        public var create:
            @Sendable (_ request: Stripe.Checkout.Sessions.Create.Request) async throws(any Swift.Error) ->
                Stripe.Checkout.Session

        public var update:
            @Sendable (
                _ id: Stripe.Checkout.Session.ID, _ request: Stripe.Checkout.Sessions.Update.Request
            ) async throws(any Swift.Error) -> Stripe.Checkout.Session

        public var retrieve:
            @Sendable (_ id: Stripe.Checkout.Session.ID) async throws(any Swift.Error) -> Stripe.Checkout.Session

        public var list:
            @Sendable (_ request: Stripe.Checkout.Sessions.List.Request) async throws(any Swift.Error) ->
                Stripe.Checkout.Sessions.List.Response

        public var expire:
            @Sendable (_ id: Stripe.Checkout.Session.ID) async throws(any Swift.Error) -> Stripe.Checkout.Session

        public var lineItems:
            @Sendable (
                _ id: Stripe.Checkout.Session.ID,
                _ request: Stripe.Checkout.Sessions.LineItems.Request
            ) async throws(any Swift.Error) -> Stripe.Checkout.Sessions.LineItems.Response
    }
}
