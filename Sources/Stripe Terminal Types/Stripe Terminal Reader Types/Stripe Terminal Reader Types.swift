import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

// MARK: - Create
extension Stripe.Terminal.Readers {
    public enum Create {}
}

extension Stripe.Terminal.Readers.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var registrationCode: String
        public var label: String?
        public var location: Stripe.Terminal.Locations.Location.ID?
        public var metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case registrationCode = "registration_code"
            case label
            case location
            case metadata
        }

        public init(
            registrationCode: String,
            label: String? = nil,
            location: Stripe.Terminal.Locations.Location.ID? = nil,
            metadata: [String: String]? = nil
        ) {
            self.registrationCode = registrationCode
            self.label = label
            self.location = location
            self.metadata = metadata
        }
    }
}

// MARK: - Update
extension Stripe.Terminal.Readers {
    public enum Update {}
}

extension Stripe.Terminal.Readers.Update {
    public struct Request: Codable, Equatable, Sendable {
        public var label: String?
        public var metadata: [String: String]?

        public init(
            label: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.label = label
            self.metadata = metadata
        }
    }
}

// MARK: - List
extension Stripe.Terminal.Readers {
    public enum List {}
}

extension Stripe.Terminal.Readers.List {
    public struct Request: Codable, Equatable, Sendable {
        public var deviceType: String?
        public var endingBefore: String?
        public var limit: Int?
        public var location: Stripe.Terminal.Locations.Location.ID?
        public var startingAfter: String?
        public var status: String?

        private enum CodingKeys: String, CodingKey {
            case deviceType = "device_type"
            case endingBefore = "ending_before"
            case limit
            case location
            case startingAfter = "starting_after"
            case status
        }

        public init(
            deviceType: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            location: Stripe.Terminal.Locations.Location.ID? = nil,
            startingAfter: String? = nil,
            status: String? = nil
        ) {
            self.deviceType = deviceType
            self.endingBefore = endingBefore
            self.limit = limit
            self.location = location
            self.startingAfter = startingAfter
            self.status = status
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Terminal.Readers.Reader]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Terminal.Readers.Reader]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// MARK: - Process Payment Intent
extension Stripe.Terminal.Readers {
    public enum ProcessPaymentIntent {}
}

extension Stripe.Terminal.Readers.ProcessPaymentIntent {
    public struct Request: Codable, Equatable, Sendable {
        public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID
        public var processConfig: ProcessConfig?

        private enum CodingKeys: String, CodingKey {
            case paymentIntent = "payment_intent"
            case processConfig = "process_config"
        }

        public init(
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID,
            processConfig: ProcessConfig? = nil
        ) {
            self.paymentIntent = paymentIntent
            self.processConfig = processConfig
        }
    }

    public struct ProcessConfig: Codable, Equatable, Sendable {
        public var skipTipping: Bool?
        public var tipping: Tipping?

        private enum CodingKeys: String, CodingKey {
            case skipTipping = "skip_tipping"
            case tipping
        }

        public init(
            skipTipping: Bool? = nil,
            tipping: Tipping? = nil
        ) {
            self.skipTipping = skipTipping
            self.tipping = tipping
        }
    }

    public struct Tipping: Codable, Equatable, Sendable {
        public var amount: Int?

        public init(amount: Int? = nil) {
            self.amount = amount
        }
    }
}

// MARK: - Process Setup Intent
extension Stripe.Terminal.Readers {
    public enum ProcessSetupIntent {}
}

extension Stripe.Terminal.Readers.ProcessSetupIntent {
    public struct Request: Codable, Equatable, Sendable {
        public var customerConsentCollected: Bool
        public var setupIntent: Stripe.Setup.Intent.ID

        private enum CodingKeys: String, CodingKey {
            case customerConsentCollected = "customer_consent_collected"
            case setupIntent = "setup_intent"
        }

        public init(
            customerConsentCollected: Bool,
            setupIntent: Stripe.Setup.Intent.ID
        ) {
            self.customerConsentCollected = customerConsentCollected
            self.setupIntent = setupIntent
        }
    }
}

// MARK: - Collect Inputs
extension Stripe.Terminal.Readers {
    public enum CollectInputs {}
}

extension Stripe.Terminal.Readers.CollectInputs {
    public struct Request: Codable, Equatable, Sendable {
        public var inputs: [Input]

        public init(inputs: [Input]) {
            self.inputs = inputs
        }
    }

    public struct Input: Codable, Equatable, Sendable {
        public var type: String
        public var required: Bool?
        public var custom: CustomInput?

        public init(
            type: String,
            required: Bool? = nil,
            custom: CustomInput? = nil
        ) {
            self.type = type
            self.required = required
            self.custom = custom
        }
    }

    public struct CustomInput: Codable, Equatable, Sendable {
        public var title: String
        public var description: String?
        public var required: Bool?
        public var buttons: [Button]?

        public init(
            title: String,
            description: String? = nil,
            required: Bool? = nil,
            buttons: [Button]? = nil
        ) {
            self.title = title
            self.description = description
            self.required = required
            self.buttons = buttons
        }
    }

    public struct Button: Codable, Equatable, Sendable {
        public var style: String?
        public var text: String

        public init(
            style: String? = nil,
            text: String
        ) {
            self.style = style
            self.text = text
        }
    }
}

// MARK: - Confirm Payment Intent
extension Stripe.Terminal.Readers {
    public enum ConfirmPaymentIntent {}
}

extension Stripe.Terminal.Readers.ConfirmPaymentIntent {
    public struct Request: Codable, Equatable, Sendable {
        public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID

        private enum CodingKeys: String, CodingKey {
            case paymentIntent = "payment_intent"
        }

        public init(paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID) {
            self.paymentIntent = paymentIntent
        }
    }
}

// MARK: - Collect Payment Method
extension Stripe.Terminal.Readers {
    public enum CollectPaymentMethod {}
}

extension Stripe.Terminal.Readers.CollectPaymentMethod {
    public struct Request: Codable, Equatable, Sendable {
        public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID
        public var collectConfig: CollectConfig?

        private enum CodingKeys: String, CodingKey {
            case paymentIntent = "payment_intent"
            case collectConfig = "collect_config"
        }

        public init(
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID,
            collectConfig: CollectConfig? = nil
        ) {
            self.paymentIntent = paymentIntent
            self.collectConfig = collectConfig
        }
    }

    public struct CollectConfig: Codable, Equatable, Sendable {
        public var skipTipping: Bool?
        public var tipping: Tipping?

        private enum CodingKeys: String, CodingKey {
            case skipTipping = "skip_tipping"
            case tipping
        }

        public init(
            skipTipping: Bool? = nil,
            tipping: Tipping? = nil
        ) {
            self.skipTipping = skipTipping
            self.tipping = tipping
        }
    }

    public struct Tipping: Codable, Equatable, Sendable {
        public var amount: Int?

        public init(amount: Int? = nil) {
            self.amount = amount
        }
    }
}

// MARK: - Refund Payment
extension Stripe.Terminal.Readers {
    public enum RefundPayment {}
}

extension Stripe.Terminal.Readers.RefundPayment {
    public struct Request: Codable, Equatable, Sendable {
        public var amount: Int?
        public var charge: Stripe.Charges.Charge.ID?
        public var metadata: [String: String]?
        public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        public var reason: String?
        public var refundApplicationFee: Bool?
        public var reverseTransfer: Bool?

        private enum CodingKeys: String, CodingKey {
            case amount
            case charge
            case metadata
            case paymentIntent = "payment_intent"
            case reason
            case refundApplicationFee = "refund_application_fee"
            case reverseTransfer = "reverse_transfer"
        }

        public init(
            amount: Int? = nil,
            charge: Stripe.Charges.Charge.ID? = nil,
            metadata: [String: String]? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            reason: String? = nil,
            refundApplicationFee: Bool? = nil,
            reverseTransfer: Bool? = nil
        ) {
            self.amount = amount
            self.charge = charge
            self.metadata = metadata
            self.paymentIntent = paymentIntent
            self.reason = reason
            self.refundApplicationFee = refundApplicationFee
            self.reverseTransfer = reverseTransfer
        }
    }
}

// MARK: - Set Reader Display
extension Stripe.Terminal.Readers {
    public enum SetReaderDisplay {}
}

extension Stripe.Terminal.Readers.SetReaderDisplay {
    public struct Request: Codable, Equatable, Sendable {
        public var type: String
        public var cart: Cart?

        public init(
            type: String,
            cart: Cart? = nil
        ) {
            self.type = type
            self.cart = cart
        }
    }

    public struct Cart: Codable, Equatable, Sendable {
        public var currency: Stripe.Currency
        public var total: Int
        public var tax: Int?
        public var lineItems: [LineItem]

        private enum CodingKeys: String, CodingKey {
            case currency
            case total
            case tax
            case lineItems = "line_items"
        }

        public init(
            currency: Stripe.Currency,
            total: Int,
            tax: Int? = nil,
            lineItems: [LineItem]
        ) {
            self.currency = currency
            self.total = total
            self.tax = tax
            self.lineItems = lineItems
        }
    }

    public struct LineItem: Codable, Equatable, Sendable {
        public var amount: Int
        public var description: String
        public var quantity: Int

        public init(
            amount: Int,
            description: String,
            quantity: Int
        ) {
            self.amount = amount
            self.description = description
            self.quantity = quantity
        }
    }
}

// MARK: - Present Payment Method (Test Helper)
extension Stripe.Terminal.Readers {
    public enum PresentPaymentMethod {}
}

extension Stripe.Terminal.Readers.PresentPaymentMethod {
    public struct Request: Codable, Equatable, Sendable {
        public var type: String?
        public var cardPresent: CardPresent?
        public var interacPresent: InteracPresent?

        private enum CodingKeys: String, CodingKey {
            case type
            case cardPresent = "card_present"
            case interacPresent = "interac_present"
        }

        public init(
            type: String? = nil,
            cardPresent: CardPresent? = nil,
            interacPresent: InteracPresent? = nil
        ) {
            self.type = type
            self.cardPresent = cardPresent
            self.interacPresent = interacPresent
        }
    }

    public struct CardPresent: Codable, Equatable, Sendable {
        public var number: String?

        public init(number: String? = nil) {
            self.number = number
        }
    }

    public struct InteracPresent: Codable, Equatable, Sendable {
        public var number: String?

        public init(number: String? = nil) {
            self.number = number
        }
    }
}
