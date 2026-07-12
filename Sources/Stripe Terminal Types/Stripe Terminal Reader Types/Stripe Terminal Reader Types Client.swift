import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Terminal.Readers {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/terminal/readers/create.md
        public var create: @Sendable (_ request: Create.Request) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/retrieve.md
        public var retrieve: @Sendable (_ id: Reader.ID) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/update.md
        public var update:
            @Sendable (_ id: Reader.ID, _ request: Update.Request) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/list.md
        public var list: @Sendable (_ request: List.Request) async throws(any Swift.Error) -> List.Response

        // https://docs.stripe.com/api/terminal/readers/delete.md
        public var delete: @Sendable (_ id: Reader.ID) async throws(any Swift.Error) -> DeletedObject<Reader>

        // https://docs.stripe.com/api/terminal/readers/cancel_action.md
        public var cancelAction: @Sendable (_ id: Reader.ID) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/process_payment_intent.md
        public var processPaymentIntent:
            @Sendable (_ id: Reader.ID, _ request: ProcessPaymentIntent.Request) async throws(any Swift.Error) ->
                Reader

        // https://docs.stripe.com/api/terminal/readers/process_setup_intent.md
        public var processSetupIntent:
            @Sendable (_ id: Reader.ID, _ request: ProcessSetupIntent.Request) async throws(any Swift.Error) ->
                Reader

        // https://docs.stripe.com/api/terminal/readers/collect_inputs.md
        public var collectInputs:
            @Sendable (_ id: Reader.ID, _ request: CollectInputs.Request) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/confirm_payment_intent.md
        public var confirmPaymentIntent:
            @Sendable (_ id: Reader.ID, _ request: ConfirmPaymentIntent.Request) async throws(any Swift.Error) ->
                Reader

        // https://docs.stripe.com/api/terminal/readers/collect_payment_method.md
        public var collectPaymentMethod:
            @Sendable (_ id: Reader.ID, _ request: CollectPaymentMethod.Request) async throws(any Swift.Error) ->
                Reader

        // https://docs.stripe.com/api/terminal/readers/refund_payment.md
        public var refundPayment:
            @Sendable (_ id: Reader.ID, _ request: RefundPayment.Request) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/terminal/readers/set_reader_display.md
        public var setReaderDisplay:
            @Sendable (_ id: Reader.ID, _ request: SetReaderDisplay.Request) async throws(any Swift.Error) -> Reader

        // https://docs.stripe.com/api/test_helpers/terminal/readers/present_payment_method.md
        public var presentPaymentMethod:
            @Sendable (_ id: Reader.ID, _ request: PresentPaymentMethod.Request) async throws(any Swift.Error) ->
                Reader
    }
}
