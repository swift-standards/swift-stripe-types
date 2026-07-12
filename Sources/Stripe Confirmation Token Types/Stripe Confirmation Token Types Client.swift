import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe {
    @Witness
    public struct ConfirmationTokenClient: Sendable {
        // https://docs.stripe.com/api/confirmation_tokens/retrieve.md
        public var retrieve:
            @Sendable (_ id: ConfirmationToken.ID) async throws(any Swift.Error) -> ConfirmationToken
    }
}
