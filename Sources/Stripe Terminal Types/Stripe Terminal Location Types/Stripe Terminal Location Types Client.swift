import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Terminal.Locations {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/terminal/locations/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Location

        // https://docs.stripe.com/api/terminal/locations/retrieve.md
        public var retrieve: @Sendable (_ id: Location.ID) async throws(Witness.Unimplemented.Error) -> Location

        // https://docs.stripe.com/api/terminal/locations/update.md
        public var update:
            @Sendable (_ id: Location.ID, _ request: Update.Request) async throws(Witness.Unimplemented.Error) -> Location

        // https://docs.stripe.com/api/terminal/locations/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response

        // https://docs.stripe.com/api/terminal/locations/delete.md
        public var delete: @Sendable (_ id: Location.ID) async throws(Witness.Unimplemented.Error) -> DeletedObject<Location>
    }
}
