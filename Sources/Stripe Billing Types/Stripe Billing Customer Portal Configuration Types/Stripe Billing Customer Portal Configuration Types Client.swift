import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Customer.Portal.Configuration {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/customer_portal/configurations/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.Customer.Portal.Configuration.Create.Request)
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Customer.Portal.Configuration

        // https://docs.stripe.com/api/customer_portal/configurations/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Customer.Portal.Configuration.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Customer.Portal.Configuration

        // https://docs.stripe.com/api/customer_portal/configurations/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Customer.Portal.Configuration.ID, _ request: Update.Request
            )
                async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Customer.Portal.Configuration

        // https://docs.stripe.com/api/customer_portal/configurations/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.Customer.Portal.Configuration.List.Request)
                async throws(Witness.Unimplemented.Error)
                -> List.Response
    }
}
