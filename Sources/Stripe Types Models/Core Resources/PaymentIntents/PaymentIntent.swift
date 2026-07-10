//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/payment_intents/object.md

extension Stripe.PaymentIntents {
    /// The [PaymentIntent Object](https://stripe.com/docs/api/payment_intents/object)
    public struct PaymentIntent: Codable, Hashable, Sendable, Identifiable {
        /// Unique identifier for the object.
        public var id: Stripe.PaymentIntents.PaymentIntent.ID
        /// Amount intended to be collected by this PaymentIntent.
        public var amount: Int?
        /// Settings to configure compatible payment methods from the Stripe Dashboard.
        public var automaticPaymentMethods: PaymentIntent.Automatic.Payment.Methods?
        /// The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key. Please refer to [dynamic authentication](https://stripe.com/docs/payments/dynamic-authentication) guide on how `client_secret` should be handled.
        public var clientSecret: String?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// ID of the Customer this PaymentIntent is for if one exists.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// The payment error encountered in the previous PaymentIntent confirmation.
        public var lastPaymentError: StripeError?
        /// The latest charge created by this payment intent.
        @ExpandableOf<Stripe.Charges.Charge> public var latestCharge: Stripe.Charges.Charge.ID?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// If present, this property tells you what actions you need to take in order for your customer to fulfill a payment using the provided source.
        public var nextAction: PaymentIntent.NextAction?
        /// ID of the payment method used in this PaymentIntent.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var paymentMethod
        /// Email address that the receipt for the resulting payment will be sent to.
        public var receiptEmail: String?
        /// Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. For more, learn to save card details after a payment. Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using `off_session` will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer.
        public var setupFutureUsage: PaymentIntent.SetupFutureUsage?
        /// Shipping information for this PaymentIntent.
        public var shipping: ShippingLabel?
        /// For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
        public var statementDescriptor: Stripe.StatementDescriptor?
        /// Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
        public var statementDescriptorSuffix: String?
        /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, or `succeeded`.
        public var status: PaymentIntent.Status?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Amount that can be captured from this PaymentIntent.
        public var amountCapturable: Int?
        /// Details about items included in the amount
        public var amountDetails: PaymentIntent.Amount.Details?
        /// Amount that was collected by this PaymentIntent.
        public var amountReceived: Int?
        /// ID of the Connect application that created the PaymentIntent.
        public var application: String?
        /// The amount of the application fee (if any) for the resulting payment. See the PaymentIntents [Connect usage guide](https://stripe.com/docs/payments/payment-intents/usage#connect) for details.
        public var applicationFeeAmount: Int?
        /// Populated when `status` is `canceled`, this is the time at which the PaymentIntent was canceled. Measured in seconds since the Unix epoch.
        public var canceledAt: Date?
        /// User-given reason for cancellation of this PaymentIntent, one of `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`.
        public var cancellationReason: PaymentIntent.Cancellation.Reason?
        /// Capture method of this PaymentIntent, one of `automatic` or `manual`.
        public var captureMethod: PaymentIntent.Capture.Method?
        /// Confirmation method of this PaymentIntent, one of `manual` or `automatic`.
        public var confirmationMethod: PaymentIntent.Confirmation.Method?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// ID of the invoice that created this PaymentIntent, if it exists.
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var invoice:
            Stripe.Billing.Invoice.ID?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// The account (if any) for which the funds of the PaymentIntent are intended. See the PaymentIntents Connect usage guide for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOn: Stripe.Connect.Account.ID?
        /// Payment-method-specific configuration for this PaymentIntent.
        public var paymentMethodOptions: PaymentIntent.Payment.Method.Options?
        /// The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
        public var paymentMethodTypes: [String]?
        /// If present, this property tells you about the processing state of the payment.
        public var processing: PaymentIntent.Processing?
        /// ID of the review associated with this PaymentIntent, if any.
        @ExpandableOf<Stripe.Fraud.Reviews.Review> public var review:
            Stripe.Fraud.Reviews.Review.ID?
        /// The data with which to automatically create a Transfer when the payment is finalized. See the PaymentIntents Connect usage guide for details.
        public var transferData: PaymentIntent.Transfer.Data?
        /// A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
        public var transferGroup: String?

        enum CodingKeys: String, CodingKey {
            case id
            case amount
            case automaticPaymentMethods = "automatic_payment_methods"
            case clientSecret = "client_secret"
            case currency
            case customer
            case description
            case lastPaymentError = "last_payment_error"
            case latestCharge = "latest_charge"
            case metadata
            case nextAction = "next_action"
            case paymentMethod = "payment_method"
            case receiptEmail = "receipt_email"
            case setupFutureUsage = "setup_future_usage"
            case shipping
            case statementDescriptor = "statement_descriptor"
            case statementDescriptorSuffix = "statement_descriptor_suffix"
            case status
            case object
            case amountCapturable = "amount_capturable"
            case amountDetails = "amount_details"
            case amountReceived = "amount_received"
            case application
            case applicationFeeAmount = "application_fee_amount"
            case canceledAt = "canceled_at"
            case cancellationReason = "cancellation_reason"
            case captureMethod = "capture_method"
            case confirmationMethod = "confirmation_method"
            case created
            case invoice
            case livemode
            case onBehalfOn = "on_behalf_of"
            case paymentMethodOptions = "payment_method_options"
            case paymentMethodTypes = "payment_method_types"
            case processing
            case review
            case transferData = "transfer_data"
            case transferGroup = "transfer_group"
        }

        public init(
            id: PaymentIntent.ID,
            amount: Int? = nil,
            automaticPaymentMethods: PaymentIntent.Automatic.Payment.Methods? = nil,
            clientSecret: String? = nil,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            lastPaymentError: StripeError? = nil,
            latestCharge: Stripe.Charges.Charge.ID? = nil,
            metadata: [String: String]? = nil,
            nextAction: PaymentIntent.NextAction? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            receiptEmail: String? = nil,
            setupFutureUsage: PaymentIntent.SetupFutureUsage? = nil,
            shipping: ShippingLabel? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            statementDescriptorSuffix: String? = nil,
            status: PaymentIntent.Status? = nil,
            object: String,
            amountCapturable: Int? = nil,
            amountDetails: PaymentIntent.Amount.Details? = nil,
            amountReceived: Int? = nil,
            application: String? = nil,
            applicationFeeAmount: Int? = nil,
            canceledAt: Date? = nil,
            cancellationReason: PaymentIntent.Cancellation.Reason? = nil,
            captureMethod: PaymentIntent.Capture.Method? = nil,
            confirmationMethod: PaymentIntent.Confirmation.Method? = nil,
            created: Date,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            livemode: Bool? = nil,
            onBehalfOn: Stripe.Connect.Account.ID? = nil,
            paymentMethodOptions: PaymentIntent.Payment.Method.Options? = nil,
            paymentMethodTypes: [String]? = nil,
            processing: PaymentIntent.Processing? = nil,
            review: Stripe.Fraud.Reviews.Review.ID? = nil,
            transferData: PaymentIntent.Transfer.Data? = nil,
            transferGroup: String? = nil
        ) {
            self.id = id
            self.amount = amount
            self.automaticPaymentMethods = automaticPaymentMethods
            self.clientSecret = clientSecret
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.description = description
            self.lastPaymentError = lastPaymentError
            self._latestCharge = Expandable(id: latestCharge)
            self.metadata = metadata
            self.nextAction = nextAction
            self._paymentMethod = Expandable(id: paymentMethod)
            self.receiptEmail = receiptEmail
            self.setupFutureUsage = setupFutureUsage
            self.shipping = shipping
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.status = status
            self.object = object
            self.amountCapturable = amountCapturable
            self.amountDetails = amountDetails
            self.amountReceived = amountReceived
            self.application = application
            self.applicationFeeAmount = applicationFeeAmount
            self.canceledAt = canceledAt
            self.cancellationReason = cancellationReason
            self.captureMethod = captureMethod
            self.confirmationMethod = confirmationMethod
            self.created = created
            self._invoice = Expandable(id: invoice)
            self.livemode = livemode
            self._onBehalfOn = Expandable(id: onBehalfOn)
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.processing = processing
            self._review = Expandable(id: review)
            self.transferData = transferData
            self.transferGroup = transferGroup
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public typealias ID = Tagged<Self, String>
}

extension Stripe.PaymentIntents.PaymentIntent {
    public struct Processing: Codable, Hashable, Sendable {
        /// If the PaymentIntent’s `payment_method_types` includes card, this hash contains the details on the processing state of the payment.
        public var card: Stripe.PaymentIntents.PaymentIntent.Processing.Card?
        /// Type of the payment method for which payment is in processing state, one of `card`.
        public var type: String?

        public init(
            card: Stripe.PaymentIntents.PaymentIntent.Processing.Card? = nil,
            type: String? = nil
        ) {
            self.card = card
            self.type = type
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent.Processing {
    public struct Card: Codable, Hashable, Sendable {
        /// For recurring payments of Indian cards, this hash contains details on whether customer approval is required, and until when the payment will be in `processing` state
        public var customerNotification:
            Stripe.PaymentIntents.PaymentIntent.Processing.Card.Customer.Notification?

        public init(
            customerNotification: Stripe.PaymentIntents.PaymentIntent.Processing.Card.Customer
                .Notification? = nil
        ) {
            self.customerNotification = customerNotification
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent.Processing.Card {
    public enum Customer {}
}

extension Stripe.PaymentIntents.PaymentIntent.Processing.Card.Customer {
    public struct Notification: Codable, Hashable, Sendable {
        /// Whether customer approval has been requested for this payment. For payments greater than INR 15000 or mandate amount, the customer must provide explicit approval of the payment with their bank.
        public var approvalRequested: Bool?
        /// If customer approval is required, they need to provide approval before this time.
        public var completesAt: Date?

        public init(
            approvalRequested: Bool? = nil,
            completesAt: Date? = nil
        ) {
            self.approvalRequested = approvalRequested
            self.completesAt = completesAt
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Automatic {}
}

extension Stripe.PaymentIntents.PaymentIntent.Automatic {
    public enum Payment {}
}

extension Stripe.PaymentIntents.PaymentIntent.Automatic.Payment {
    public struct Methods: Codable, Hashable, Sendable {
        /// Automatically calculates compatible payment methods
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum SetupFutureUsage: String, Codable, Sendable {
        case onSession = "on_session"
        case offSession = "off_session"
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Transfer {}
}

extension Stripe.PaymentIntents.PaymentIntent.Transfer {
    public struct Data: Codable, Hashable, Sendable {
        /// Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
        public var amount: Int?
        /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        public init(
            amount: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Cancellation {}
}

extension Stripe.PaymentIntents.PaymentIntent.Cancellation {
    public enum Reason: String, Codable, Sendable {
        case abandoned
        case automatic
        case duplicate
        case failedInvoice = "failed_invoice"
        case fraudulent
        case requestedByCustomer = "requested_by_customer"
        case voidInvoice = "void_invoice"
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Capture {}
}

extension Stripe.PaymentIntents.PaymentIntent.Capture {
    public enum Method: String, Codable, Sendable {
        /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
        case automatic
        case automaticAsync = "automatic_async"
        /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later. (Not all payment methods support this.)
        case manual
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Confirmation {

    }
}

extension Stripe.PaymentIntents.PaymentIntent.Confirmation {
    public enum Method: String, Codable, Sendable {
        /// (Default) PaymentIntent can be confirmed using a publishable key. After `next_action`s are handled, no additional confirmation is required to complete the payment.
        case automatic
        /// All payment attempts must be made using a secret key. The PaymentIntent returns to the `requires_confirmation` state after handling `next_action`s, and requires your server to initiate each payment attempt with an explicit confirmation.
        case manual
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Status: String, Codable, Sendable {
        case requiresPaymentMethod = "requires_payment_method"
        case requiresConfirmation = "requires_confirmation"
        case requiresAction = "requires_action"
        case processing
        case requiresCapture = "requires_capture"
        case canceled
        case succeeded
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Amount {}
}

extension Stripe.PaymentIntents.PaymentIntent.Amount {
    public struct Details: Codable, Hashable, Sendable {
        /// Portion of the amount that corresponds to a tip.
        public var tip: Stripe.PaymentIntents.PaymentIntent.Amount.Details.Tip?

        public init(
            tip: Stripe.PaymentIntents.PaymentIntent.Amount.Details.Tip? = nil
        ) {
            self.tip = tip
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent.Amount.Details {
    public struct Tip: Codable, Hashable, Sendable {
        /// Portion of the amount that corresponds to a tip.
        public var amount: Int?

        public init(
            amount: Int? = nil
        ) {
            self.amount = amount
        }
    }
}

// extension Stripe.PaymentIntents.PaymentIntent {
//    public enum PaymentMethod {}
// }

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Payment {}
}

extension Stripe.PaymentIntents.PaymentIntent.Payment {
    public enum Method {}
}

extension Stripe.PaymentIntents.PaymentIntent.Payment.Method {

    public typealias Data = Options

    public struct Options: Codable, Hashable, Sendable {
        /// If the PaymentIntent’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let acssDebit: Stripe.PaymentMethods.PaymentMethod.Options.ACSSDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `affirm`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let affirm: Stripe.PaymentMethods.PaymentMethod.Options.Affirm.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let afterpayClearpay:
            Stripe.PaymentMethods.PaymentMethod.Options.AfterpayClearpay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let alipay: Stripe.PaymentMethods.PaymentMethod.Options.Alipay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `au_becs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let auBecsDebit:
            Stripe.PaymentMethods.PaymentMethod.Options.AUBecsDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `bacs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let bacsDebit: Stripe.PaymentMethods.PaymentMethod.Options.BacsDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let bancontact: Stripe.PaymentMethods.PaymentMethod.Options.Bancontact.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes blik, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let blik: Stripe.PaymentMethods.PaymentMethod.Options.Blik.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let boleto: Stripe.PaymentMethods.PaymentMethod.Options.Boleto.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let card: Stripe.PaymentMethods.PaymentMethod.Options.Card.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `card_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let cardPresent:
            Stripe.PaymentMethods.PaymentMethod.Options.CardPresent.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `customer_balance`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let customerBalance:
            Stripe.PaymentMethods.PaymentMethod.Options.CustomerBalance.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `eps`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let eps: Stripe.PaymentMethods.PaymentMethod.Options.EPS.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `fpx`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let fpx: Stripe.PaymentMethods.PaymentMethod.Options.FPX.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let giropay: Stripe.PaymentMethods.PaymentMethod.Options.Giropay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `grabpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let grabpay: Stripe.PaymentMethods.PaymentMethod.Options.GrabPay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let ideal: Stripe.PaymentMethods.PaymentMethod.Options.Ideal.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `interac_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let interacPresent:
            Stripe.PaymentMethods.PaymentMethod.Options.InteracPresent.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let klarna: Stripe.PaymentMethods.PaymentMethod.Options.Klarna.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `konbini`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let konbini: Stripe.PaymentMethods.PaymentMethod.Options.Konbini.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let link: Stripe.PaymentMethods.PaymentMethod.Options.Link.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let oxxo: Stripe.PaymentMethods.PaymentMethod.Options.OXXO.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let p24: Stripe.PaymentMethods.PaymentMethod.Options.P24.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `paynow`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let paynow: Stripe.PaymentMethods.PaymentMethod.Options.Paynow.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `pix`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let pix: Stripe.PaymentMethods.PaymentMethod.Options.Pix.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `promptpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let promptpay: Stripe.PaymentMethods.PaymentMethod.Options.PromptPay.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let sepaDebit: Stripe.PaymentMethods.PaymentMethod.Options.SepaDebit.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let sofort: Stripe.PaymentMethods.PaymentMethod.Options.Sofort.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let usBankAccount:
            Stripe.PaymentMethods.PaymentMethod.Options.USBankAccount.Configuration?
        /// If the PaymentIntent’s `payment_method_types` includes `wechat_pay`, this hash contains the configurations that will be applied to each payment attempt of that type.
        public let wechatPay: Stripe.PaymentMethods.PaymentMethod.Options.WechatPay.Configuration?

        public init(
            acssDebit: Stripe.PaymentMethods.PaymentMethod.Options.ACSSDebit.Configuration? = nil,
            affirm: Stripe.PaymentMethods.PaymentMethod.Options.Affirm.Configuration? = nil,
            afterpayClearpay: Stripe.PaymentMethods.PaymentMethod.Options.AfterpayClearpay
                .Configuration? = nil,
            alipay: Stripe.PaymentMethods.PaymentMethod.Options.Alipay.Configuration? = nil,
            auBecsDebit: Stripe.PaymentMethods.PaymentMethod.Options.AUBecsDebit.Configuration? =
                nil,
            bacsDebit: Stripe.PaymentMethods.PaymentMethod.Options.BacsDebit.Configuration? = nil,
            bancontact: Stripe.PaymentMethods.PaymentMethod.Options.Bancontact.Configuration? = nil,
            blik: Stripe.PaymentMethods.PaymentMethod.Options.Blik.Configuration? = nil,
            boleto: Stripe.PaymentMethods.PaymentMethod.Options.Boleto.Configuration? = nil,
            card: Stripe.PaymentMethods.PaymentMethod.Options.Card.Configuration? = nil,
            cardPresent: Stripe.PaymentMethods.PaymentMethod.Options.CardPresent.Configuration? =
                nil,
            customerBalance: Stripe.PaymentMethods.PaymentMethod.Options.CustomerBalance
                .Configuration? =
                nil,
            eps: Stripe.PaymentMethods.PaymentMethod.Options.EPS.Configuration? = nil,
            fpx: Stripe.PaymentMethods.PaymentMethod.Options.FPX.Configuration? = nil,
            giropay: Stripe.PaymentMethods.PaymentMethod.Options.Giropay.Configuration? = nil,
            grabpay: Stripe.PaymentMethods.PaymentMethod.Options.GrabPay.Configuration? = nil,
            ideal: Stripe.PaymentMethods.PaymentMethod.Options.Ideal.Configuration? = nil,
            interacPresent: Stripe.PaymentMethods.PaymentMethod.Options.InteracPresent
                .Configuration? =
                nil,
            klarna: Stripe.PaymentMethods.PaymentMethod.Options.Klarna.Configuration? = nil,
            konbini: Stripe.PaymentMethods.PaymentMethod.Options.Konbini.Configuration? = nil,
            link: Stripe.PaymentMethods.PaymentMethod.Options.Link.Configuration? = nil,
            oxxo: Stripe.PaymentMethods.PaymentMethod.Options.OXXO.Configuration? = nil,
            p24: Stripe.PaymentMethods.PaymentMethod.Options.P24.Configuration? = nil,
            paynow: Stripe.PaymentMethods.PaymentMethod.Options.Paynow.Configuration? = nil,
            pix: Stripe.PaymentMethods.PaymentMethod.Options.Pix.Configuration? = nil,
            promptpay: Stripe.PaymentMethods.PaymentMethod.Options.PromptPay.Configuration? = nil,
            sepaDebit: Stripe.PaymentMethods.PaymentMethod.Options.SepaDebit.Configuration? = nil,
            sofort: Stripe.PaymentMethods.PaymentMethod.Options.Sofort.Configuration? = nil,
            usBankAccount: Stripe.PaymentMethods.PaymentMethod.Options.USBankAccount
                .Configuration? = nil,
            wechatPay: Stripe.PaymentMethods.PaymentMethod.Options.WechatPay.Configuration? = nil
        ) {
            self.acssDebit = acssDebit
            self.affirm = affirm
            self.afterpayClearpay = afterpayClearpay
            self.alipay = alipay
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.bancontact = bancontact
            self.blik = blik
            self.boleto = boleto
            self.card = card
            self.cardPresent = cardPresent
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.giropay = giropay
            self.grabpay = grabpay
            self.ideal = ideal
            self.interacPresent = interacPresent
            self.klarna = klarna
            self.konbini = konbini
            self.link = link
            self.oxxo = oxxo
            self.p24 = p24
            self.paynow = paynow
            self.pix = pix
            self.promptpay = promptpay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.usBankAccount = usBankAccount
            self.wechatPay = wechatPay
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent {
    public enum Search {}
}

extension Stripe.PaymentIntents.PaymentIntent.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of charges, paginated by any request parameters.
        public var data: [Stripe.PaymentIntents.PaymentIntent]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.PaymentIntents.PaymentIntent]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
