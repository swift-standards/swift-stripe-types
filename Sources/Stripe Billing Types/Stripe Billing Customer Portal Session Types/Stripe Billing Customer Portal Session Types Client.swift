import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Customer.Portal.Session {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/customer_portal/sessions/create.md
        public var create:
            @Sendable (_ request: Create.Request) async throws(any Swift.Error) ->
                Stripe.Billing.Customer.Portal.Session

    }
}
