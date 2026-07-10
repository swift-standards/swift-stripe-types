import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.PaymentMethods.Sources {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/sources/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Models.Source

        // https://docs.stripe.com/api/sources/retrieve.md
        public var retrieve: @Sendable (_ id: Stripe_Types_Models.Source.ID) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Models.Source

        // https://docs.stripe.com/api/sources/update.md
        public var update:
            @Sendable (_ id: Stripe_Types_Models.Source.ID, _ request: Update.Request) async throws(Witness.Unimplemented.Error) -> Stripe_Types_Models.Source

        // https://docs.stripe.com/api/sources/attach.md
        public var attach:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ source: Stripe_Types_Models.Source.ID) async throws(Witness.Unimplemented.Error)
                ->
                Stripe_Types_Models.Source

        // https://docs.stripe.com/api/sources/detach.md
        public var detach:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ sourceId: Stripe_Types_Models.Source.ID)
                async throws(Witness.Unimplemented.Error) ->
                Stripe_Types_Models.Source
    }
}
