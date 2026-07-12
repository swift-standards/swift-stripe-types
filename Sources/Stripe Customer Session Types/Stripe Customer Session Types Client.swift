import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Customers.Customer.Sessions {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/customer_sessions/create.md
        public var create:
            @Sendable (_ request: Stripe.Customers.Customer.Sessions.Create.Request) async throws(any Swift.Error) ->
                Stripe.Customers.Customer.Session
    }
}
