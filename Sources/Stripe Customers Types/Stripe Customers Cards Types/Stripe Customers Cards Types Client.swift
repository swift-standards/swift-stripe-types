import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers.Cards {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/cards/create.md
        public var create:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: Create.Request)
                async throws(any Swift.Error)
                -> Card

        // https://docs.stripe.com/api/cards/retrieve.md
        public var retrieve:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ cardId: Card.ID) async throws(any Swift.Error)
                -> Card

        // https://docs.stripe.com/api/cards/update.md
        public var update:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID, _ cardId: Card.ID,
                _ request: Update.Request
            ) async throws(any Swift.Error) -> Card

        // https://docs.stripe.com/api/cards/list.md
        public var list:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: List.Request)
                async throws(any Swift.Error)
                -> List.Response

        // https://docs.stripe.com/api/cards/delete.md
        public var delete:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ cardId: Card.ID) async throws(any Swift.Error)
                ->
                DeletedObject<Card>
    }
}
