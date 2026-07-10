import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Products.PromotionCodes {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/promotion_codes/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(Witness.Unimplemented.Error) -> Promotion.Code

        // https://docs.stripe.com/api/promotion_codes/retrieve.md
        public var retrieve: @Sendable (_ id: Promotion.Code.ID) async throws(Witness.Unimplemented.Error) -> Promotion.Code

        // https://docs.stripe.com/api/promotion_codes/update.md
        public var update:
            @Sendable (_ id: Promotion.Code.ID, _ request: Update.Request) async throws(Witness.Unimplemented.Error) ->
                Promotion.Code

        // https://docs.stripe.com/api/promotion_codes/list.md
        public var list: @Sendable (_ request: List.Request) async throws(Witness.Unimplemented.Error) -> List.Response
    }
}
