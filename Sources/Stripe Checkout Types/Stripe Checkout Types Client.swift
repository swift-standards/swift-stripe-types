import Foundation
import Stripe_Types_Shared

extension Stripe.Checkout {
    @dynamicMemberLookup
    public struct Client: Sendable {
        public let sessions: Stripe.Checkout.Sessions.Client

        public init(
            sessions: Stripe.Checkout.Sessions.Client
        ) {
            self.sessions = sessions
        }

        public subscript<T>(dynamicMember keyPath: KeyPath<Stripe.Checkout.Sessions.Client, T>) -> T
        {
            sessions[keyPath: keyPath]
        }
    }
}
