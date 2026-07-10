//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/charges/object.md

extension Stripe.Charges {
    /// The [Charge Object](https://stripe.com/docs/api/charges/object)
    public struct Charge: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// A positive integer in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency) representing how much to charge. The minimum amount is $0.50 US or [equivalent in charge currency](https://support.stripe.com/questions/what-is-the-minimum-amount-i-can-charge-with-stripe).
        public var amount: Int?
        /// Amount in cents captured (can be less than the amount attribute on the charge if a partial capture was made).
        public var amountCaptured: Int?
        /// Amount in cents refunded (can be less than the amount attribute on the charge if a partial refund was issued).
        public var amountRefunded: Int?
        /// ID of the Connect application that created the charge.
        public var application: String?
        /// The application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
        @ExpandableOf<Stripe.Connect.Application.Fee> public var applicationFee:
            Stripe.Connect.Application.Fee.ID?
        /// The amount of the application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
        public var applicationFeeAmount: Int?
        /// ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).
        @ExpandableOf<Stripe.Balance.Transaction> public var balanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Billing information associated with the payment method at the time of the transaction.
        public var billingDetails: BillingModel.Details?
        /// The full statement descriptor that is passed to card networks, and that is displayed on your customers’ credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined.
        public var calculatedStatementDescriptor: String?
        /// If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.
        public var captured: Bool?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// ID of the customer this charge is for if one exists.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Details about the dispute if the charge has been disputed.
        public var dispute: String?
        /// Whether the charge has been disputed.
        public var disputed: Bool?
        /// ID of the balance transaction that describes the reversal of the balance on your account due to payment failure.
        @ExpandableOf<Stripe.Balance.Transaction> public var failureBalanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Error code explaining reason for charge failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
        public var failureCode: String?
        /// Message to user further explaining reason for charge failure if available.
        public var failureMessage: String?
        /// Information on fraud assessments for the charge.
        public var fraudDetails: Stripe.Charges.Charge.Fraud.Details?
        /// ID of the invoice this charge is for if one exists.
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var invoice:
            Stripe.Billing.Invoice.ID?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers) for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// Details about whether the payment was accepted, and why. See [understanding declines](https://stripe.com/docs/declines) for details.
        public var outcome: Stripe.Charges.Charge.Outcome?
        /// `true` if the charge succeeded, or was successfully authorized for later capture.
        public var paid: Bool?
        /// ID of the PaymentIntent associated with this charge, if one exists.
        @ExpandableOf<Stripe.PaymentIntents.PaymentIntent> public var paymentIntent:
            Stripe.PaymentIntents.PaymentIntent.ID?
        /// ID of the payment method used in this charge.
        public var paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        /// Details about the payment method at the time of the transaction.
        public var paymentMethodDetails: Stripe.Charges.Charge.PaymentMethod.Details?
        /// Options to configure Radar. See Radar Session for more information.
        public var radarOptions: Stripe.Charges.Charge.Radar.Options?
        /// This is the email address that the receipt for this charge was sent to.
        public var receiptEmail: String?
        /// This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.
        public var receiptNumber: String?
        /// This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.
        public var receiptUrl: String?
        /// Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
        public var refunded: Bool?
        /// A list of refunds that have been applied to the charge.
        public var refunds: Stripe.Refunds.Refund.List?
        /// ID of the review associated with this charge if one exists.
        @ExpandableOf<Stripe.Fraud.Reviews.Review> public var review:
            Stripe.Fraud.Reviews.Review.ID?
        /// Shipping information for the charge.
        public var shipping: ShippingLabel?
        /// The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
        @ExpandableOf<Stripe.Connect.Transfer> public var sourceTransfer:
            Stripe.Connect.Transfer.ID?
        /// Extra information about a charge. This will appear on your customer’s credit card statement. It must contain at least one letter.
        public var statementDescriptor: Stripe.StatementDescriptor?
        /// Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
        public var statementDescriptorSuffix: String?
        /// The status of the payment is either `succeeded`, `pending`, or `failed`.
        public var status: Stripe.Charges.Charge.Status?
        /// ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).
        @ExpandableOf<Stripe.Connect.Transfer> public var transfer: Stripe.Connect.Transfer.ID?
        /// An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
        public var transferData: Stripe.Charges.Charge.Transfer.Data?
        /// A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
        public var transferGroup: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            amountCaptured: Int? = nil,
            amountRefunded: Int? = nil,
            application: String? = nil,
            applicationFee: Stripe.Connect.Application.Fee.ID? = nil,
            applicationFeeAmount: Int? = nil,
            balanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            billingDetails: BillingModel.Details? = nil,
            calculatedStatementDescriptor: String? = nil,
            captured: Bool? = nil,
            created: Date,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            dispute: String? = nil,
            disputed: Bool? = nil,
            failureBalanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            failureCode: String? = nil,
            failureMessage: String? = nil,
            fraudDetails: Stripe.Charges.Charge.Fraud.Details? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            outcome: Stripe.Charges.Charge.Outcome? = nil,
            paid: Bool? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            paymentMethodDetails: Stripe.Charges.Charge.PaymentMethod.Details? = nil,
            radarOptions: Stripe.Charges.Charge.Radar.Options? = nil,
            receiptEmail: String? = nil,
            receiptNumber: String? = nil,
            receiptUrl: String? = nil,
            refunded: Bool? = nil,
            refunds: Stripe.Refunds.Refund.List? = nil,
            review: Stripe.Fraud.Reviews.Review.ID? = nil,
            shipping: ShippingLabel? = nil,
            sourceTransfer: Stripe.Connect.Transfer.ID? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            statementDescriptorSuffix: String? = nil,
            status: Stripe.Charges.Charge.Status? = nil,
            transfer: Stripe.Connect.Transfer.ID? = nil,
            transferData: Stripe.Charges.Charge.Transfer.Data? = nil,
            transferGroup: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountCaptured = amountCaptured
            self.amountRefunded = amountRefunded
            self.application = application
            self._applicationFee = Expandable(id: applicationFee)
            self.applicationFeeAmount = applicationFeeAmount
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.billingDetails = billingDetails
            self.calculatedStatementDescriptor = calculatedStatementDescriptor
            self.captured = captured
            self.created = created
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.description = description
            self.dispute = dispute
            self.disputed = disputed
            self._failureBalanceTransaction = Expandable(id: failureBalanceTransaction)
            self.failureCode = failureCode
            self.failureMessage = failureMessage
            self.fraudDetails = fraudDetails
            self._invoice = Expandable(id: invoice)
            self.livemode = livemode
            self.metadata = metadata
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.outcome = outcome
            self.paid = paid
            self._paymentIntent = Expandable(id: paymentIntent)
            self.paymentMethod = paymentMethod
            self.paymentMethodDetails = paymentMethodDetails
            self.radarOptions = radarOptions
            self.receiptEmail = receiptEmail
            self.receiptNumber = receiptNumber
            self.receiptUrl = receiptUrl
            self.refunded = refunded
            self.refunds = refunds
            self._review = Expandable(id: review)
            self.shipping = shipping
            self._sourceTransfer = Expandable(id: sourceTransfer)
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.status = status
            self._transfer = Expandable(id: transfer)
            self.transferData = transferData
            self.transferGroup = transferGroup
        }
    }
}

extension Stripe.Charges.Charge {
    public enum Radar {}
}

extension Stripe.Charges.Charge {
    public enum Fraud {}
}

extension Stripe.Charges.Charge.Fraud {
    public struct Details: Codable, Hashable, Sendable {
        /// Assessments reported by you. If set, possible values of are `safe` and `fraudulent`.
        public var userReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`?
        /// Assessments from Stripe. If set, the value is `fraudulent`.
        public var stripeReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`?

        public init(
            userReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`? = nil,
            stripeReport: Stripe.Charges.Charge.Fraud.Details.Report.`Type`? = nil
        ) {
            self.userReport = userReport
            self.stripeReport = stripeReport
        }
    }
}

extension Stripe.Charges.Charge.Fraud.Details {
    public enum Report {}
}

extension Stripe.Charges.Charge.Fraud.Details.Report {
    public enum `Type`: String, Codable, Sendable {
        case safe
        case fraudulent
    }
}

extension Stripe.Charges.Charge.Outcome {
    public enum Network {}
}

extension Stripe.Charges.Charge.Outcome {
    public enum Risk {}
}

extension Stripe.Charges.Charge {
    public struct Outcome: Codable, Hashable, Sendable {
        /// Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and `reversed_after_approval`. The value `reversed_after_approval` indicates the payment was [blocked by Stripe](https://stripe.com/docs/declines#blocked-payments) after bank authorization, and may temporarily appear as “pending” on a cardholder’s statement.
        public var networkStatus: Stripe.Charges.Charge.Outcome.Network.Status?
        /// An enumerated value providing a more detailed explanation of the outcome’s `type`. Charges blocked by Radar’s default block rule have the value `highest_risk_level`. Charges placed in review by Radar’s default review rule have the value `elevated_risk_level`. Charges authorized, blocked, or placed in review by custom rules have the value `rule`. See [understanding declines](https://stripe.com/docs/declines) for more details.
        public var reason: String?
        /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are `normal`, `elevated`, `highest`. For non-card payments, and card-based payments predating the public assignment of risk levels, this field will have the value `not_assessed`. In the event of an error in the evaluation, this field will have the value `unknown`.
        public var riskLevel: Stripe.Charges.Charge.Outcome.Risk.Level?
        /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are between 0 and 100. For non-card payments, card-based payments predating the public assignment of risk scores, or in the event of an error during evaluation, this field will not be present. This field is only available with Radar for Fraud Teams.
        public var riskScore: Int?
        /// The ID of the Radar rule that matched the payment, if applicable.
        public var rule: String?
        /// A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer.
        public var sellerMessage: String?
        /// Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`. See understanding declines and Radar reviews for details.
        public var type: Stripe.Charges.Charge.Outcome.`Type`?

        public init(
            networkStatus: Stripe.Charges.Charge.Outcome.Network.Status? = nil,
            reason: String? = nil,
            riskLevel: Stripe.Charges.Charge.Outcome.Risk.Level? = nil,
            riskScore: Int? = nil,
            rule: String? = nil,
            sellerMessage: String? = nil,
            type: Stripe.Charges.Charge.Outcome.`Type`? = nil
        ) {
            self.networkStatus = networkStatus
            self.reason = reason
            self.riskLevel = riskLevel
            self.riskScore = riskScore
            self.rule = rule
            self.sellerMessage = sellerMessage
            self.type = type
        }
    }
}

extension Stripe.Charges.Charge.Outcome.Network {
    public enum Status: String, Codable, Sendable {
        case approvedByNetwork = "approved_by_network"
        case declinedByNetwork = "declined_by_network"
        case notSentToNetwork = "not_sent_to_network"
        case reversedAfterApproval = "reversed_after_approval"
    }
}

extension Stripe.Charges.Charge.Outcome.Risk {
    public enum Level: String, Codable, Sendable {
        case normal
        case elevated
        case highest
        case notAssessed = "not_assessed"
        case unknown
    }
}

extension Stripe.Charges.Charge.Outcome {
    public enum `Type`: String, Codable, Sendable {
        case authorized
        case manualReview = "manual_review"
        case issuerDeclined = "issuer_declined"
        case blocked
        case invalid
    }
}

extension Stripe.Charges.Charge {
    public enum Status: String, Codable, Sendable {
        case succeeded
        case pending
        case failed
    }
}

extension Stripe.Charges.Charge {
    public enum Transfer {}
}

extension Stripe.Charges.Charge.Transfer {
    public struct Data: Codable, Hashable, Sendable {
        /// The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
        public var amount: Int?
        /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
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

extension Stripe.Charges.Charge {
    public enum Search {}
}

extension Stripe.Charges.Charge.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of charges, paginated by any request parameters.
        public var data: [Stripe.Charges.Charge]?
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
            data: [Stripe.Charges.Charge]? = nil,
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

extension Stripe.Charges.Charge {
    public enum PaymentMethod {}
}

extension Stripe.Charges.Charge.PaymentMethod {
    public struct Details: Codable, Hashable, Sendable {
        /// If this is a `ach_credit_transfer` payment, this hash contains a snapshot of the transaction specific details of the `ach_credit_transfer` payment method.
        public var achCreditTransfer:
            Stripe.Charges.Charge.PaymentMethod.Details.ACHCredit.Transfer?
        /// If this is a `ach_debit` payment, this hash contains a snapshot of the transaction specific details of the `ach_debit` payment method.
        public var achDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACHDebit?
        /// If this is a `acss_debit` payment, this hash contains a snapshot of the transaction specific details of the `acss_debit` payment method.
        public var acssDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACSSDebit?
        /// If this is a `affirm` payment, this hash contains a snapshot of the transaction specific details of the `affirm` payment method.
        public var affirm: Stripe.Charges.Charge.PaymentMethod.Details.Affirm?
        /// If this is a `afterpay_clearpay` payment, this hash contains a snapshot of the transaction specific details of the `afterpay_clearpay` payment method.
        public var afterpayClearpay: Stripe.Charges.Charge.PaymentMethod.Details.AfterpayClearpay?
        /// If this is a `alipay` payment, this hash contains a snapshot of the transaction specific details of the `alipay` payment method.
        public var alipay: Stripe.Charges.Charge.PaymentMethod.Details.Alipay?
        /// If this is a `au_becs_debit` payment, this hash contains a snapshot of the transaction specific details of the `au_becs_debit` payment method.
        public var auBecsDebit: Stripe.Charges.Charge.PaymentMethod.Details.AuBecsDebit?
        /// If this is a `bacs_debit` payment, this hash contains a snapshot of the transaction specific details of the `bacs_debit` payment method.
        public var bacsDebit: Stripe.Charges.Charge.PaymentMethod.Details.BacsDebit?
        /// If this is a `bancontact` payment, this hash contains a snapshot of the transaction specific details of the `bancontact` payment method.
        public var bancontact: Stripe.Charges.Charge.PaymentMethod.Details.Bancontact?
        /// If this is a `blik` payment, this hash contains a snapshot of the transaction specific details of the `blik` payment method.
        public var blik: Stripe.Charges.Charge.PaymentMethod.Details.Blik?
        /// If this is a `boleto` payment, this hash contains a snapshot of the transaction specific details of the `boleto` payment method.
        public var boleto: Stripe.Charges.Charge.PaymentMethod.Details.Boleto?
        /// If this is a `card` payment, this hash contains a snapshot of the transaction specific details of the `card` payment method.
        public var card: Stripe.Charges.Charge.PaymentMethod.Details.Card?
        /// If this is a `card_present` payment, this hash contains a snapshot of the transaction specific details of the `card_present` payment method.
        public var cardPresent: Stripe.Charges.Charge.PaymentMethod.Details.CardPresent?
        /// If this is a `cashapp` payment, this hash contains a snapshot of the transaction specific details of the `cashapp` payment method.
        public var cashapp: Stripe.Charges.Charge.PaymentMethod.Details.CashApp?
        /// If this is a `customer_balance` payment, this hash contains a snapshot of the transaction specific details of the `customer_balance` payment method.
        public var customerBalance: Stripe.Charges.Charge.PaymentMethod.Details.CustomerBalance?
        /// If this is a `eps` payment, this hash contains a snapshot of the transaction specific details of the `eps` payment method.
        public var eps: Stripe.Charges.Charge.PaymentMethod.Details.EPS?
        /// If this is a `fpx` payment, this hash contains a snapshot of the transaction specific details of the `fpx` payment method.
        public var fpx: Stripe.Charges.Charge.PaymentMethod.Details.Fpx?
        /// If this is a `grabpay` payment, this hash contains a snapshot of the transaction specific details of the `grabpay` payment method.
        public var grabpay: Stripe.Charges.Charge.PaymentMethod.Details.Grabpay?
        /// If this is a `giropay` payment, this hash contains a snapshot of the transaction specific details of the `giropay` payment method.
        public var giropay: Stripe.Charges.Charge.PaymentMethod.Details.Giropay?
        /// If this is a `ideal` payment, this hash contains a snapshot of the transaction specific details of the `ideal` payment method.
        public var ideal: Stripe.Charges.Charge.PaymentMethod.Details.Ideal?
        /// If this is a `interac_present` payment, this hash contains a snapshot of the transaction specific details of the `interac_present` payment method.
        public var interacPresent: Stripe.Charges.Charge.PaymentMethod.Details.InteracPresent?
        /// If this is a klarna payment, this hash contains a snapshot of the transaction specific details of the klarna payment method.
        public var klarna: Stripe.Charges.Charge.PaymentMethod.Details.Klarna?
        /// If this is a konbini payment, this hash contains a snapshot of the transaction specific details of the konbini payment method.
        public var konbini: Stripe.Charges.Charge.PaymentMethod.Details.Kobini?
        /// If this is a `link` payment, this hash contains a snapshot of the transaction specific details of the `link` payment method.
        public var link: Stripe.Charges.Charge.PaymentMethod.Details.Link?
        /// If this is a `multibanco` payment, this hash contains a snapshot of the transaction specific details of the `multibanco` payment method.
        public var multibanco: Stripe.Charges.Charge.PaymentMethod.Details.Multibanco?
        /// If this is a oxxo payment, this hash contains a snapshot of the transaction specific details of the oxxo payment method.
        public var oxxo: Stripe.Charges.Charge.PaymentMethod.Details.OXXO?
        /// If this is a `p24` payment, this hash contains a snapshot of the transaction specific details of the `p24` payment method.
        public var p24: Stripe.Charges.Charge.PaymentMethod.Details.P24?
        /// If this is a `paynow` payment, this hash contains a snapshot of the transaction specific details of the `paynow` payment method.
        public var paynow: Stripe.Charges.Charge.PaymentMethod.Details.Paynow?
        /// If this is a `paypal` payment, this hash contains a snapshot of the transaction specific details of the `paypal` payment method.
        public var paypal: Stripe.Charges.Charge.PaymentMethod.Details.Paypal?
        /// If this is a `pix` payment, this hash contains a snapshot of the transaction specific details of the `pix` payment method.
        public var pix: Stripe.Charges.Charge.PaymentMethod.Details.Pix?
        /// If this is a `promptpay` payment, this hash contains a snapshot of the transaction specific details of the `promptpay` payment method.
        public var promptpay: Stripe.Charges.Charge.PaymentMethod.Details.Promptpay?
        /// If this is a `sepa_debit` payment, this hash contains a snapshot of the transaction specific details of the `sepa_debit` payment method.
        public var sepaDebit: Stripe.Charges.Charge.PaymentMethod.Details.SepaDebit?
        /// If this is a `sofort` payment, this hash contains a snapshot of the transaction specific details of the `sofort` payment method
        public var sofort: Stripe.Charges.Charge.PaymentMethod.Details.Sofort?
        /// If this is a `stripe_account` payment, this hash contains a snapshot of the transaction specific details of the `stripe_account` payment method
        public var stripeAccount: Stripe.Charges.Charge.PaymentMethod.Details.StripeAccount?
        /// The type of transaction-specific details of the payment method used in the payment, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `p24`, `sepa_debit`, `sofort`, `stripe_account`, or `wechat`. An additional hash is included on `payment_method_details` with a name matching this value. It contains information specific to the payment method.
        public var type: Stripe.Charges.Charge.PaymentMethod.Details.`Type`?
        /// If this is a `us_bank_account` payment, this hash contains a snapshot of the transaction specific details of the `us_bank_account` payment method.
        public var usBankAccount: Stripe.Charges.Charge.PaymentMethod.Details.USBankAccount?
        /// If this is a `wechat` payment, this hash contains a snapshot of the transaction specific details of the `wechat` payment method.
        public var wechat: Stripe.Charges.Charge.PaymentMethod.Details.Wechat?
        /// If this is a `wechat_pay` payment, this hash contains a snapshot of the transaction specific details of the `wechat_pay` payment method.
        public var wechatPay: Stripe.Charges.Charge.PaymentMethod.Details.WechatPay?
        /// If this is a zip payment, this hash contains a snapshot of the transaction specific details of the zip payment method.
        public var zip: Stripe.Charges.Charge.PaymentMethod.Details.Zip?

        public init(
            achCreditTransfer: Stripe.Charges.Charge.PaymentMethod.Details.ACHCredit.Transfer? =
                nil,
            achDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACHDebit? = nil,
            acssDebit: Stripe.Charges.Charge.PaymentMethod.Details.ACSSDebit? = nil,
            affirm: Stripe.Charges.Charge.PaymentMethod.Details.Affirm? = nil,
            afterpayClearpay: Stripe.Charges.Charge.PaymentMethod.Details.AfterpayClearpay? = nil,
            alipay: Stripe.Charges.Charge.PaymentMethod.Details.Alipay? = nil,
            auBecsDebit: Stripe.Charges.Charge.PaymentMethod.Details.AuBecsDebit? = nil,
            bacsDebit: Stripe.Charges.Charge.PaymentMethod.Details.BacsDebit? = nil,
            bancontact: Stripe.Charges.Charge.PaymentMethod.Details.Bancontact? = nil,
            blik: Stripe.Charges.Charge.PaymentMethod.Details.Blik? = nil,
            boleto: Stripe.Charges.Charge.PaymentMethod.Details.Boleto? = nil,
            card: Stripe.Charges.Charge.PaymentMethod.Details.Card? = nil,
            cardPresent: Stripe.Charges.Charge.PaymentMethod.Details.CardPresent? = nil,
            cashapp: Stripe.Charges.Charge.PaymentMethod.Details.CashApp? = nil,
            customerBalance: Stripe.Charges.Charge.PaymentMethod.Details.CustomerBalance? = nil,
            eps: Stripe.Charges.Charge.PaymentMethod.Details.EPS? = nil,
            fpx: Stripe.Charges.Charge.PaymentMethod.Details.Fpx? = nil,
            grabpay: Stripe.Charges.Charge.PaymentMethod.Details.Grabpay? = nil,
            giropay: Stripe.Charges.Charge.PaymentMethod.Details.Giropay? = nil,
            ideal: Stripe.Charges.Charge.PaymentMethod.Details.Ideal? = nil,
            interacPresent: Stripe.Charges.Charge.PaymentMethod.Details.InteracPresent? = nil,
            klarna: Stripe.Charges.Charge.PaymentMethod.Details.Klarna? = nil,
            konbini: Stripe.Charges.Charge.PaymentMethod.Details.Kobini? = nil,
            link: Stripe.Charges.Charge.PaymentMethod.Details.Link? = nil,
            multibanco: Stripe.Charges.Charge.PaymentMethod.Details.Multibanco? = nil,
            oxxo: Stripe.Charges.Charge.PaymentMethod.Details.OXXO? = nil,
            p24: Stripe.Charges.Charge.PaymentMethod.Details.P24? = nil,
            paynow: Stripe.Charges.Charge.PaymentMethod.Details.Paynow? = nil,
            paypal: Stripe.Charges.Charge.PaymentMethod.Details.Paypal? = nil,
            pix: Stripe.Charges.Charge.PaymentMethod.Details.Pix? = nil,
            promptpay: Stripe.Charges.Charge.PaymentMethod.Details.Promptpay? = nil,
            sepaDebit: Stripe.Charges.Charge.PaymentMethod.Details.SepaDebit? = nil,
            sofort: Stripe.Charges.Charge.PaymentMethod.Details.Sofort? = nil,
            stripeAccount: Stripe.Charges.Charge.PaymentMethod.Details.StripeAccount? = nil,
            type: Stripe.Charges.Charge.PaymentMethod.Details.`Type`? = nil,
            usBankAccount: Stripe.Charges.Charge.PaymentMethod.Details.USBankAccount? = nil,
            wechat: Stripe.Charges.Charge.PaymentMethod.Details.Wechat? = nil,
            wechatPay: Stripe.Charges.Charge.PaymentMethod.Details.WechatPay? = nil,
            zip: Stripe.Charges.Charge.PaymentMethod.Details.Zip? = nil
        ) {
            self.achCreditTransfer = achCreditTransfer
            self.achDebit = achDebit
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
            self.cashapp = cashapp
            self.customerBalance = customerBalance
            self.eps = eps
            self.fpx = fpx
            self.grabpay = grabpay
            self.giropay = giropay
            self.ideal = ideal
            self.interacPresent = interacPresent
            self.klarna = klarna
            self.link = link
            self.konbini = konbini
            self.multibanco = multibanco
            self.oxxo = oxxo
            self.p24 = p24
            self.paynow = paynow
            self.paypal = paypal
            self.pix = pix
            self.promptpay = promptpay
            self.sepaDebit = sepaDebit
            self.sofort = sofort
            self.stripeAccount = stripeAccount
            self.type = type
            self.usBankAccount = usBankAccount
            self.wechat = wechat
            self.wechatPay = wechatPay
            self.zip = zip
        }
    }
}

extension Stripe.Charges.Charge.PaymentMethod.Details {
    public enum `Type`: String, Codable, Sendable {
        case achCreditTransfer = "ach_credit_transfer"
        case achDebit = "ach_debit"
        case acssDebit = "acss_debit"
        case affirm
        case afterpayClearpay = "afterpay_clearpay"
        case alipay
        case auBecsDebit = "au_becs_debit"
        case bacsDebit = "bacs_debit"
        case bancontact
        case blik
        case boleto
        case card
        case cardPresent = "card_present"
        case cashapp
        case customerBalance = "customer_balance"
        case eps
        case fpx
        case giropay
        case grabpay
        case ideal
        case interacPresent = "interac_present"
        case klarna
        case konbini
        case link
        case multibanco
        case oxxo
        case p24
        case paynow
        case paypal
        case pix
        case promptpay
        case sepaDebit = "sepa_debit"
        case sofort
        case stripeAccount = "stripe_account"
        case usBankAccount = "us_bank_account"
        case wechat
        case wechatPay = "wechat_pay"
        case zip
    }
}

extension Stripe.Charges.Charge.Radar {
    public struct Options: Codable, Hashable, Sendable {
        /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        public var session: String?

        public init(
            session: String? = nil
        ) {
            self.session = session
        }
    }
}
