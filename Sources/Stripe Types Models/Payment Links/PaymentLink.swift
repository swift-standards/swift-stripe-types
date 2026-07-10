//
//  PaymentLink.swift
//
//
//  Created by Andrew Edwards on 5/7/23.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/payment-link/object.md

extension Stripe {
    public struct PaymentLink: Codable, Hashable, Sendable, Identifiable {
        /// Unique identifier for the object.
        public var id: Stripe.PaymentLink.ID
        /// Whether the payment link’s `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.
        public var active: Bool?
        /// The line items representing what is being sold. This field is not included by default. To include it in the response, expand the `line_items` field.
        public var lineItems: Stripe.PaymentLink.LineItem.List?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The public URL that can be shared with customers.
        public var url: String?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Behavior after the purchase is complete.
        public var afterCompletion: Stripe.PaymentLink.After.Completion?
        /// Whether user redeemable promotion codes are enabled.
        public var allowPromotionCodes: Bool?
        /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account.
        public var applicationFeeAmount: Int?
        /// This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account.
        public var applicationFeePercent: Decimal?
        /// Configuration details for automatic tax collection.
        public var automaticTax: Stripe.PaymentLink.AutomaticTax?
        /// Configuration for collecting the customer’s billing address.
        public var billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection?
        /// When set, provides configuration to gather active consent from customers.
        public var consentCollection: Stripe.PaymentLink.Consent.Collection?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Collect additional information from your customer using custom fields. Up to 2 fields are supported.
        public var customFields: [Stripe.PaymentLink.CustomField]?
        /// Display additional text for your customers using custom text.
        public var customText: Stripe.PaymentLink.Custom.Text?
        /// Configuration for Customer creation during checkout.
        public var customerCreation: Stripe.PaymentLink.Customer.Creation?
        /// The custom message to be displayed to a customer when a payment link is no longer active
        public var inactiveMessage: String?
        /// Configuration for creating invoice for payment mode payment links.
        public var invoiceCreation: Stripe.PaymentLink.Invoice.Creation?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// The account on behalf of which to charge. See the Connect documentation for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// Indicates the parameters to be passed to PaymentIntent creation during checkout.
        public var paymentIntentData: Stripe.PaymentLink.PaymentIntent.Data?
        /// Configuration for collecting a payment method during checkout.
        public var paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection?
        /// The list of payment method types that customers can use. When `null`, Stripe will dynamically show relevant payment methods you’ve enabled in your payment method settings.
        public var paymentMethodTypes: [String]?
        /// Controls phone number collection settings during checkout.
        public var phoneNumberCollection: PhoneNumber.Collection?
        ///
        public var restrictions: Stripe.PaymentLink.Restrictions?
        /// Configuration for collecting the customer’s shipping address.
        public var shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection?
        /// The shipping rate options applied to the session.
        public var shippingOptions: [Stripe.PaymentLink.Shipping.Option]?
        /// Indicates the type of transaction being performed which customizes relevant text on the page, such as the submit button.
        public var submitType: Stripe.PaymentLink.Submit.`Type`?
        /// When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`.
        public var subscriptionData: Stripe.PaymentLink.Subscription.Data?
        /// Details on the state of tax ID collection for the payment link.
        public var taxIdCollection: Stripe.PaymentLink.TaxId.Collection?
        /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to.
        public var transferData: Stripe.PaymentLink.Transfer.Data?

        public init(
            id: Stripe.PaymentLink.ID,
            active: Bool? = nil,
            lineItems: Stripe.PaymentLink.LineItem.List? = nil,
            metadata: [String: String]? = nil,
            url: String? = nil,
            object: String,
            afterCompletion: Stripe.PaymentLink.After.Completion? = nil,
            allowPromotionCodes: Bool? = nil,
            applicationFeeAmount: Int? = nil,
            applicationFeePercent: Decimal? = nil,
            automaticTax: Stripe.PaymentLink.AutomaticTax? = nil,
            billingAddressCollection: Stripe.PaymentLink.Billing.Address.Collection? = nil,
            consentCollection: Stripe.PaymentLink.Consent.Collection? = nil,
            currency: Stripe.Currency? = nil,
            customFields: [Stripe.PaymentLink.CustomField]? = nil,
            customText: Stripe.PaymentLink.Custom.Text? = nil,
            customerCreation: Stripe.PaymentLink.Customer.Creation? = nil,
            inactiveMessage: String? = nil,
            invoiceCreation: Stripe.PaymentLink.Invoice.Creation? = nil,
            livemode: Bool? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            paymentIntentData: Stripe.PaymentLink.PaymentIntent.Data? = nil,
            paymentMethodCollection: Stripe.PaymentLink.PaymentMethod.Collection? = nil,
            paymentMethodTypes: [String]? = nil,
            phoneNumberCollection: PhoneNumber.Collection? = nil,
            shippingAddressCollection: Stripe.PaymentLink.Shipping.Address.Collection? = nil,
            shippingOptions: [Stripe.PaymentLink.Shipping.Option]? = nil,
            submitType: Stripe.PaymentLink.Submit.`Type`? = nil,
            subscriptionData: Stripe.PaymentLink.Subscription.Data? = nil,
            taxIdCollection: Stripe.PaymentLink.TaxId.Collection? = nil,
            transferData: Stripe.PaymentLink.Transfer.Data? = nil
        ) {
            self.id = id
            self.active = active
            self.lineItems = lineItems
            self.metadata = metadata
            self.url = url
            self.object = object
            self.afterCompletion = afterCompletion
            self.allowPromotionCodes = allowPromotionCodes
            self.applicationFeeAmount = applicationFeeAmount
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingAddressCollection = billingAddressCollection
            self.consentCollection = consentCollection
            self.currency = currency
            self.customFields = customFields
            self.customText = customText
            self.customerCreation = customerCreation
            self.inactiveMessage = inactiveMessage
            self.invoiceCreation = invoiceCreation
            self.livemode = livemode
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.paymentIntentData = paymentIntentData
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodTypes = paymentMethodTypes
            self.phoneNumberCollection = phoneNumberCollection
            self.shippingAddressCollection = shippingAddressCollection
            self.shippingOptions = shippingOptions
            self.submitType = submitType
            self.subscriptionData = subscriptionData
            self.taxIdCollection = taxIdCollection
            self.transferData = transferData
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case active
            case lineItems = "line_items"
            case metadata
            case url
            case object
            case afterCompletion = "after_completion"
            case allowPromotionCodes = "allow_promotion_codes"
            case applicationFeeAmount = "application_fee_amount"
            case applicationFeePercent = "application_fee_percent"
            case automaticTax = "automatic_tax"
            case billingAddressCollection = "billing_address_collection"
            case consentCollection = "consent_collection"
            case currency
            case customFields = "custom_fields"
            case customText = "custom_text"
            case customerCreation = "customer_creation"
            case inactiveMessage = "inactive_message"
            case invoiceCreation = "invoice_creation"
            case livemode
            case onBehalfOf = "on_behalf_of"
            case paymentIntentData = "payment_intent_data"
            case paymentMethodCollection = "payment_method_collection"
            case paymentMethodTypes = "payment_method_types"
            case phoneNumberCollection = "phone_number_collection"
            case restrictions
            case shippingAddressCollection = "shipping_address_collection"
            case shippingOptions = "shipping_options"
            case submitType = "submit_type"
            case subscriptionData = "subscription_data"
            case taxIdCollection = "tax_id_collection"
            case transferData = "transfer_data"
        }
    }
}

extension Stripe.PaymentLink {
    public struct Restrictions: Codable, Hashable, Sendable {
        public let completedSessions: CompletedSessions

        private enum CodingKeys: String, CodingKey {
            case completedSessions = "completed_sessions"
        }

        public init(completedSessions: CompletedSessions) {
            self.completedSessions = completedSessions
        }

        public struct CompletedSessions: Codable, Hashable, Sendable {
            public let limit: Int

            public init(limit: Int) {
                self.limit = limit
            }
        }
    }

}
extension Stripe.PaymentLink {
    public typealias ID = Tagged<Self, String>
}

extension Stripe.PaymentLink {
    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        /// Unique identifier for the object.
        public var id: Stripe.PaymentLink.LineItem.ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Total discount amount applied. If no discounts were applied, defaults to 0.
        public var amountDiscount: Int?
        /// Total before any discounts or taxes is applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total after discounts and taxes.
        public var amountTotal: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
        public var description: String?
        /// The discounts applied to the line item. This field is not included by default. To include it in the response, expand the `discounts` field.
        public var discounts: [Stripe.PaymentLink.LineItem.Discount]?
        /// The price used to generate the line item.
        public var price: Stripe.Products.Price?
        /// The quantity of products being purchased.
        public var quantity: Int?
        /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
        public var taxes: [Stripe.PaymentLink.LineItem.Tax]?

        public init(
            id: Stripe.PaymentLink.LineItem.ID,
            object: String,
            amountDiscount: Int? = nil,
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discounts: [Stripe.PaymentLink.LineItem.Discount]? = nil,
            price: Stripe.Products.Price? = nil,
            quantity: Int? = nil,
            taxes: [Stripe.PaymentLink.LineItem.Tax]? = nil
        ) {
            self.id = id
            self.object = object
            self.amountDiscount = amountDiscount
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self.currency = currency
            self.description = description
            self.discounts = discounts
            self.price = price
            self.quantity = quantity
            self.taxes = taxes
        }
    }
}

extension Stripe.PaymentLink.LineItem {
    public typealias ID = Tagged<Self, String>
}

extension Stripe.PaymentLink.LineItem {
    public struct Discount: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        /// The discount applied.
        public var discount: Stripe.Products.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

extension Stripe.PaymentLink.LineItem {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil
        ) {
            self.amount = amount
            self.rate = rate
        }
    }
}

extension Stripe.PaymentLink.LineItem {
    public struct List: Codable, Hashable, Sendable {
        /// String representing the object’s type. Objects of the same type share the same value. Always has the value `list`.
        public var object: String
        /// Details about each object.
        public var data: [Stripe.PaymentLink.LineItem]?
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool?
        /// The URL where this list can be accessed.
        public var url: String?

        public init(
            object: String,
            data: [Stripe.PaymentLink.LineItem]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}

extension Stripe.PaymentLink {
    public enum After {}
}

extension Stripe.PaymentLink.After {
    public struct Completion: Codable, Hashable, Sendable {
        /// Configuration when `type=hosted_confirmation`
        public var hostedConfirmation: Stripe.PaymentLink.After.Completion.Hosted.Confirmation?
        /// Configuration when `type=redirect`
        public var redirect: Stripe.PaymentLink.After.Completion.Redirect?
        /// The specified behavior after the purchase is complete.
        public var type: Stripe.PaymentLink.After.Completion.`Type`?

        public init(
            hostedConfirmation: Stripe.PaymentLink.After.Completion.Hosted.Confirmation? = nil,
            redirect: Stripe.PaymentLink.After.Completion.Redirect? = nil,
            type: Stripe.PaymentLink.After.Completion.`Type`? = nil
        ) {
            self.hostedConfirmation = hostedConfirmation
            self.redirect = redirect
            self.type = type
        }

        private enum CodingKeys: String, CodingKey {
            case hostedConfirmation = "hosted_confirmation"
            case redirect
            case type
        }
    }
}

extension Stripe.PaymentLink.After.Completion {
    public enum Hosted {}
}

extension Stripe.PaymentLink.After.Completion.Hosted {
    public struct Confirmation: Codable, Hashable, Sendable {
        /// The custom message that is displayed to the customer after the purchase is complete.
        public var message: String?

        private enum CodingKeys: String, CodingKey {
            case message = "custom_message"
        }

        public init(
            message: String? = nil
        ) {
            self.message = message
        }

        // Add decoding init to handle custom messages
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
}

extension Stripe.PaymentLink.After.Completion {
    public struct Redirect: Codable, Hashable, Sendable {
        /// The URL the customer will be redirected to after the purchase is complete
        public var url: String?

        public init(
            url: String? = nil
        ) {
            self.url = url
        }
    }
}

extension Stripe.PaymentLink.After.Completion {
    public enum `Type`: String, Codable, Sendable {
        /// Redirects the customer to the specified url after the purchase is complete.
        case redirect
        /// Displays a message on the hosted surface after the purchase is complete.
        case hostedConfirmation = "hosted_confirmation"
    }
}

extension Stripe.PaymentLink {
    public struct AutomaticTax: Codable, Hashable, Sendable {
        /// If `true`, tax will be calculated automatically using the customer’s location.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentLink {
    public enum Billing {}
}

extension Stripe.PaymentLink.Billing {
    public enum Address {}
}

extension Stripe.PaymentLink.Billing.Address {
    public enum Collection: String, Codable, Sendable {
        /// Checkout will only collect the billing address when necessary. When using `automatic_tax`, Checkout will collect the minimum number of fields required for tax calculation
        case auto
        /// Checkout will always collect the customer’s billing address.
        case `required`
    }
}

extension Stripe.PaymentLink {
    public enum Consent {}
}

extension Stripe.PaymentLink.Consent {
    public struct Collection: Codable, Hashable, Sendable {
        /// If set to `auto`, enables the collection of customer consent for promotional communications.
        public var promotions: String?
        /// If set to `required`, it requires cutomers to accept the terms of service before being able to pay. If set to none, customers won’t be shown a checkbox to accept the terms of service.
        public var termsOfService: String?

        public init(
            promotions: String? = nil,
            termsOfService: String? = nil
        ) {
            self.promotions = promotions
            self.termsOfService = termsOfService
        }
    }
}

extension Stripe.PaymentLink {
    public struct CustomField: Codable, Hashable, Sendable {
        /// Configuration for `type=dropdown` fields.
        public var dropdown: Stripe.PaymentLink.CustomField.Dropdown?
        /// String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
        public var key: String?
        /// The label for the field, displayed to the customer.
        public var label: Stripe.PaymentLink.CustomField.Label?
        /// Configuration for `type=numeric` fields.
        public var numeric: Stripe.PaymentLink.CustomField.Numeric?
        /// Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
        public var optional: Bool?
        /// Configuration for `type=text` fields.
        public var text: Stripe.PaymentLink.CustomField.Text?
        /// The type of the field.
        public var type: Stripe.PaymentLink.CustomField.`Type`?

        public init(
            dropdown: Stripe.PaymentLink.CustomField.Dropdown? = nil,
            key: String? = nil,
            label: Stripe.PaymentLink.CustomField.Label? = nil,
            numeric: Stripe.PaymentLink.CustomField.Numeric? = nil,
            optional: Bool? = nil,
            text: Stripe.PaymentLink.CustomField.Text? = nil,
            type: Stripe.PaymentLink.CustomField.`Type`? = nil
        ) {
            self.dropdown = dropdown
            self.key = key
            self.label = label
            self.numeric = numeric
            self.optional = optional
            self.text = text
            self.type = type
        }
    }
}

extension Stripe.PaymentLink.CustomField {
    public struct Dropdown: Codable, Hashable, Sendable {
        /// The options available for the customer to select. Up to 200 options allowed
        public var options: [Stripe.PaymentLink.CustomField.Dropdown.Option]?
        /// The option selected by the customer. This will be the `value` for the option.
        public var value: String?

        public init(
            options: [Stripe.PaymentLink.CustomField.Dropdown.Option]? = nil,
            value: String? = nil
        ) {
            self.options = options
            self.value = value
        }
    }
}

extension Stripe.PaymentLink.CustomField.Dropdown {
    public struct Option: Codable, Hashable, Sendable {
        /// The label for the option, displayed to the customer. Up to 100 characters.
        public var label: String?
        /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
        public var value: String?

        public init(
            label: String? = nil,
            value: String? = nil
        ) {
            self.label = label
            self.value = value
        }
    }
}

extension Stripe.PaymentLink.CustomField {
    public struct Label: Codable, Hashable, Sendable {
        /// Custom text for the label, displayed to the customer. Up to 50 characters.
        public var custom: String?
        /// The type of the label.
        public var type: Stripe.PaymentLink.CustomField.LabelType?

        public init(
            custom: String? = nil,
            type: Stripe.PaymentLink.CustomField.LabelType? = nil
        ) {
            self.custom = custom
            self.type = type
        }
    }
}

extension Stripe.PaymentLink.CustomField {
    public enum LabelType: String, Codable, Sendable {
        /// Set a custom label for the field.
        case custom
    }
}

extension Stripe.PaymentLink.CustomField {
    public struct Numeric: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer, containing only digits.
        public var value: String?

        public init(
            maximumLength: Int? = nil,
            minimumLength: Int? = nil,
            value: String? = nil
        ) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
            self.value = value
        }
    }
}

extension Stripe.PaymentLink.CustomField {
    public struct Text: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer.
        public var value: String?

        public init(
            maximumLength: Int? = nil,
            minimumLength: Int? = nil,
            value: String? = nil
        ) {
            self.maximumLength = maximumLength
            self.minimumLength = minimumLength
            self.value = value
        }
    }
}

extension Stripe.PaymentLink.CustomField {
    public enum `Type`: String, Codable, Sendable {
        /// Collect a string field from your customer.
        case text
        /// Collect a numbers-only field from your customer.
        case numeric
        /// Provide a list of options for your customer to select.
        case dropdown
    }
}

extension Stripe.PaymentLink {
    public enum Custom {}
}

extension Stripe.PaymentLink.Custom {
    public struct Text: Codable, Hashable, Sendable {
        /// Custom text that should be displayed alongside shipping address collection.
        public var shippingAddress: Stripe.PaymentLink.Custom.Text.Shipping.Address?
        /// Custom text that should be displayed alongside the payment confirmation button.
        public var submit: Stripe.PaymentLink.Custom.Text.Submit?

        public init(
            shippingAddress: Stripe.PaymentLink.Custom.Text.Shipping.Address? = nil,
            submit: Stripe.PaymentLink.Custom.Text.Submit? = nil
        ) {
            self.shippingAddress = shippingAddress
            self.submit = submit
        }
    }
}

extension Stripe.PaymentLink.Custom.Text {
    public enum Shipping {}
}

extension Stripe.PaymentLink.Custom.Text.Shipping {
    public struct Address: Codable, Hashable, Sendable {
        /// Text may be up to 1000 characters in length.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}

extension Stripe.PaymentLink.Custom.Text {
    public struct Submit: Codable, Hashable, Sendable {
        /// Text may be up to 1000 characters in length.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}

extension Stripe.PaymentLink {
    public enum Customer {}
}

extension Stripe.PaymentLink.Customer {
    public enum Creation: String, Codable, Sendable {
        /// The Checkout Session will only create a Customer if it is required for Session confirmation. Currently, only `subscription` mode Sessions require a Customer.
        case ifRequired = "if_required"
        /// The Checkout Session will always create a Customer when a Session confirmation is attempted.
        case always
    }
}

extension Stripe.PaymentLink {
    public enum Invoice {}
}

extension Stripe.PaymentLink.Invoice {
    public struct Creation: Codable, Hashable, Sendable {
        /// Indicates whether invoice creation is enabled for the Checkout Session.
        public var enabled: Bool?
        /// Parameters passed when creating invoices for payment-mode Checkout Sessions.
        public var invoiceData: Stripe.PaymentLink.Invoice.Creation.Invoice.Data?

        public init(
            enabled: Bool? = nil,
            invoiceData: Stripe.PaymentLink.Invoice.Creation.Invoice.Data? = nil
        ) {
            self.enabled = enabled
            self.invoiceData = invoiceData
        }
    }
}

extension Stripe.PaymentLink.Invoice.Creation {
    public enum Invoice {}
}

extension Stripe.PaymentLink.Invoice.Creation.Invoice {
    public struct Data: Codable, Hashable, Sendable {
        /// The account tax IDs associated with the invoice
        @ExpandableCollection<Stripe.Tax.ID> public var accountTaxIds: [String]?
        /// Custom fields displayed on the invoice.
        public var customFields: [Stripe.PaymentLink.Invoice.Creation.Invoice.Data.CustomFields]?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Footer displayed on the invoice.
        public var footer: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// Options for invoice PDF rendering.
        public var renderingOptions:
            Stripe.PaymentLink.Invoice.Creation.Invoice.Data.Rendering.Options?

        public init(
            accountTaxIds: [String]? = nil,
            customFields: [Stripe.PaymentLink.Invoice.Creation.Invoice.Data.CustomFields]? = nil,
            description: String? = nil,
            footer: String? = nil,
            metadata: [String: String]? = nil,
            renderingOptions: Stripe.PaymentLink.Invoice.Creation.Invoice.Data.Rendering.Options? =
                nil
        ) {
            self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
            self.customFields = customFields
            self.description = description
            self.footer = footer
            self.metadata = metadata
            self.renderingOptions = renderingOptions
        }
    }
}

extension Stripe.PaymentLink.Invoice.Creation.Invoice.Data {
    public enum Rendering {}
}

extension Stripe.PaymentLink.Invoice.Creation.Invoice.Data {
    public struct CustomFields: Codable, Hashable, Sendable {
        /// The name of the custom field.
        public var name: String?
        /// The value of the custom field.
        public var value: String?

        public init(
            name: String? = nil,
            value: String? = nil
        ) {
            self.name = name
            self.value = value
        }
    }
}

extension Stripe.PaymentLink.Invoice.Creation.Invoice.Data.Rendering {
    public struct Options: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.PaymentLink {
    public enum PaymentIntent {}
}

extension Stripe.PaymentLink.PaymentIntent {
    public struct Data: Codable, Hashable, Sendable {
        /// Indicates when the funds will be captured from the customer’s account.
        public var captureMethod: Stripe.PaymentLink.PaymentIntent.Data.Capture.Method?
        /// Indicates that you intend to make future payments with the payment method collected during checkout.
        public var setupFutureUsage: Stripe.PaymentLink.PaymentIntent.Data.Setup.FutureUsage?

        public init(
            captureMethod: Stripe.PaymentLink.PaymentIntent.Data.Capture.Method? = nil,
            setupFutureUsage: Stripe.PaymentLink.PaymentIntent.Data.Setup.FutureUsage? = nil
        ) {
            self.captureMethod = captureMethod
            self.setupFutureUsage = setupFutureUsage
        }
    }
}

extension Stripe.PaymentLink.PaymentIntent.Data {
    public enum Capture {}
}

extension Stripe.PaymentLink.PaymentIntent.Data {
    public enum Setup {}
}

extension Stripe.PaymentLink.PaymentIntent.Data.Capture {
    public enum Method: String, Codable, Sendable {
        /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
        case automatic
        /// Stripe asynchronously captures funds when the customer authorizes the payment. Recommended over `capture_method=automatic` due to improved latency, but [may require additional integration changes](https://stripe.com/docs/payments/payment-intents/asynchronous-capture-automatic-async) .
        case automaticAsync = "automatic_async"
        /// Place a hold on the funds when the customer authorizes the payment, but [don’t capture the funds until later](https://stripe.com/docs/payments/capture-later). (Not all payment methods support this.)
        case manual
    }
}

extension Stripe.PaymentLink.PaymentIntent.Data.Setup {
    public enum FutureUsage: String, Codable, Sendable {
        /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
        case onSession = "on_session"
        /// Use `off_session` if your customer may or may not be present in your checkout flow.
        case offSession = "off_session"
    }
}

extension Stripe.PaymentLink {
    public enum PaymentMethod {}
}

extension Stripe.PaymentLink.PaymentMethod {
    public enum Collection: String, Codable, Sendable {
        /// The Checkout Session will always collect a PaymentMethod.
        case always
        /// The Checkout Session will only collect a PaymentMethod if there is an amount due.
        case ifRequired = "if_required"
    }
}

extension Stripe.PaymentLink {
    public enum Shipping {}
}

extension Stripe.PaymentLink.Shipping {
    public enum Address {}
}

extension Stripe.PaymentLink.Shipping.Address {
    public struct Collection: Codable, Hashable, Sendable {
        /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
        public var allowedCountries: [String]?

        public init(
            allowedCountries: [String]? = nil
        ) {
            self.allowedCountries = allowedCountries
        }
    }
}

extension Stripe.PaymentLink.Shipping {
    public struct Option: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var shippingAmount: Int?
        /// The shipping rate.
        @ExpandableOf<Stripe.Products.Shipping.Rate> public var shippingRate

        public init(
            shippingAmount: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil
        ) {
            self.shippingAmount = shippingAmount
            self._shippingRate = Expandable(id: shippingRate)
        }
    }
}

extension Stripe.PaymentLink {
    public enum Submit {}
}

extension Stripe.PaymentLink.Submit {
    public enum `Type`: String, Codable, Sendable {
        case auto
        case book
        case donate
        case pay
    }
}

extension Stripe.PaymentLink {
    public enum Subscription {}
}

extension Stripe.PaymentLink.Subscription {
    public struct Data: Codable, Hashable, Sendable {
        /// The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
        public var description: String?
        /// Integer representing the number of trial period days before the customer is charged for the first time.
        public var trialPeriodDays: Int?

        public init(
            description: String? = nil,
            trialPeriodDays: Int? = nil
        ) {
            self.description = description
            self.trialPeriodDays = trialPeriodDays
        }
    }
}

extension Stripe.PaymentLink {
    public enum TaxId {}
}

extension Stripe.PaymentLink.TaxId {
    public struct Collection: Codable, Hashable, Sendable {
        /// Indicates whether tax ID collection is enabled for the session
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentLink {
    public enum Transfer {}
}

extension Stripe.PaymentLink.Transfer {
    public struct Data: Codable, Hashable, Sendable {
        /// The amount in cents that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
        public var amount: Int?
        /// The connected account receiving the transfer.
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

extension Stripe.PaymentLink {
    public struct List: Codable, Hashable, Sendable {
        /// String representing the object’s type. Objects of the same type share the same value. Always has the value `list`.
        public var object: String
        /// Details about each object.
        public var data: [Stripe.PaymentLink]?
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool?
        /// The URL where this list can be accessed.
        public var url: String?

        public init(
            object: String,
            data: [Stripe.PaymentLink]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
