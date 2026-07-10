import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.Alerts {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/billing/alert/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Alert

        // https://docs.stripe.com/api/billing/alert/retrieve.md
        public var retrieve: @Sendable (_ id: Alert.ID) async throws(Witness.Unimplemented.Error) -> Alert

        // https://docs.stripe.com/api/billing/alert/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response

        // https://docs.stripe.com/api/billing/alert/activate.md
        public var activate: @Sendable (_ id: Alert.ID) async throws(Witness.Unimplemented.Error) -> Alert

        // https://docs.stripe.com/api/billing/alert/archive.md
        public var archive: @Sendable (_ id: Alert.ID) async throws(Witness.Unimplemented.Error) -> Alert

        // https://docs.stripe.com/api/billing/alert/deactivate.md
        public var deactivate: @Sendable (_ id: Alert.ID) async throws(Witness.Unimplemented.Error) -> Alert
    }
}
