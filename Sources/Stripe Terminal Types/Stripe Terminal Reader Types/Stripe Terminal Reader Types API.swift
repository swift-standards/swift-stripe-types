import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Terminal.Readers {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/terminal/readers/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/terminal/readers/retrieve.md
        case retrieve(id: Reader.ID)
        // https://docs.stripe.com/api/terminal/readers/update.md
        case update(id: Reader.ID, request: Update.Request)
        // https://docs.stripe.com/api/terminal/readers/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/terminal/readers/delete.md
        case delete(id: Reader.ID)
        // https://docs.stripe.com/api/terminal/readers/cancel_action.md
        case cancelAction(id: Reader.ID)
        // https://docs.stripe.com/api/terminal/readers/process_payment_intent.md
        case processPaymentIntent(id: Reader.ID, request: ProcessPaymentIntent.Request)
        // https://docs.stripe.com/api/terminal/readers/process_setup_intent.md
        case processSetupIntent(id: Reader.ID, request: ProcessSetupIntent.Request)
        // https://docs.stripe.com/api/terminal/readers/collect_inputs.md
        case collectInputs(id: Reader.ID, request: CollectInputs.Request)
        // https://docs.stripe.com/api/terminal/readers/confirm_payment_intent.md
        case confirmPaymentIntent(id: Reader.ID, request: ConfirmPaymentIntent.Request)
        // https://docs.stripe.com/api/terminal/readers/collect_payment_method.md
        case collectPaymentMethod(id: Reader.ID, request: CollectPaymentMethod.Request)
        // https://docs.stripe.com/api/terminal/readers/refund_payment.md
        case refundPayment(id: Reader.ID, request: RefundPayment.Request)
        // https://docs.stripe.com/api/terminal/readers/set_reader_display.md
        case setReaderDisplay(id: Reader.ID, request: SetReaderDisplay.Request)
        // https://docs.stripe.com/api/test_helpers/terminal/readers/present_payment_method.md
        case presentPaymentMethod(id: Reader.ID, request: PresentPaymentMethod.Request)
    }
}

extension Stripe.Terminal.Readers.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Terminal.Readers.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Terminal.Readers.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Terminal.Readers.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // TODO: Fix list route query parameter parsing
                // URLRouting.Route(.case(Stripe.Terminal.Readers.API.list)) {
                //     Method.get
                //     Path.v1
                //     Path.terminal
                //     Path.readers
                // }

                URLRouting.Route(.case(Stripe.Terminal.Readers.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Terminal.Readers.API.cases.cancelAction)) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.cancelAction
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.processPaymentIntent))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.processPaymentIntent
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.ProcessPaymentIntent.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.processSetupIntent))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.processSetupIntent
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.ProcessSetupIntent.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.collectInputs))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.collectInputs
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.CollectInputs.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.confirmPaymentIntent))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.confirmPaymentIntent
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.ConfirmPaymentIntent.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.collectPaymentMethod))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.collectPaymentMethod
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.CollectPaymentMethod.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.refundPayment))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.refundPayment
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.RefundPayment.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.setReaderDisplay))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.setReaderDisplay
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.SetReaderDisplay.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Readers.API.cases.presentPaymentMethod))) {
                    Method.post
                    Path.v1
                    Path.testHelpers
                    Path.terminal
                    Path.readers
                    Path { Parse(.string.representing(Stripe.Terminal.Readers.Reader.ID.self)) }
                    Path.presentPaymentMethod
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Readers.PresentPaymentMethod.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var terminal: Path<PathBuilder.Component<String>> { Path {
        "terminal"
    } }

    public static var readers: Path<PathBuilder.Component<String>> { Path {
        "readers"
    } }

    public static var cancelAction: Path<PathBuilder.Component<String>> { Path {
        "cancel_action"
    } }

    public static var processPaymentIntent: Path<PathBuilder.Component<String>> { Path {
        "process_payment_intent"
    } }

    public static var processSetupIntent: Path<PathBuilder.Component<String>> { Path {
        "process_setup_intent"
    } }

    public static var collectInputs: Path<PathBuilder.Component<String>> { Path {
        "collect_inputs"
    } }

    public static var confirmPaymentIntent: Path<PathBuilder.Component<String>> { Path {
        "confirm_payment_intent"
    } }

    public static var collectPaymentMethod: Path<PathBuilder.Component<String>> { Path {
        "collect_payment_method"
    } }

    public static var refundPayment: Path<PathBuilder.Component<String>> { Path {
        "refund_payment"
    } }

    public static var setReaderDisplay: Path<PathBuilder.Component<String>> { Path {
        "set_reader_display"
    } }

    public static var testHelpers: Path<PathBuilder.Component<String>> { Path {
        "test_helpers"
    } }

    public static var presentPaymentMethod: Path<PathBuilder.Component<String>> { Path {
        "present_payment_method"
    } }
}
