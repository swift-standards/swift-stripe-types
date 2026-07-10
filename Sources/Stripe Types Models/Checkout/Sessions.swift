//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//
import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/checkout/sessions/object.md

extension Stripe.Checkout {
    /// The [Stripe.Checkout.Session Object.](https://stripe.com/docs/api/checkout/sessions/object)
    public struct Session: Codable, Hashable, Sendable, Identifiable {
        /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
        public var id: Stripe.Checkout.Session.ID
        /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
        public var cancelUrl: String?
        /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
        public var clientReferenceId: String?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
        public var customerEmail: String?
        /// The line items purchased by the customer. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `line_items` field.
        public var lineItems: Stripe.Checkout.Session.LineItem.List?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
        public var mode: Stripe.Checkout.Session.Mode?
        /// The ID of the PaymentIntent created if SKUs or line items were provided.
        @ExpandableOf<Stripe.PaymentIntents.PaymentIntent> public var paymentIntent
        /// The payment status of the Checkout Session, one of `paid`, `unpaid`, or `no_payment_required`. You can use this value to decide when to fulfill your customer’s order.
        public var paymentStatus: Stripe.Checkout.Session.Payment.Status?
        /// The status of the Checkout Session, one of `open`, `complete`, or `expired`.
        public var status: Stripe.Checkout.Session.Status?
        /// The URL the customer will be directed to after the payment or subscription creation is successful.
        public var successUrl: String?
        /// The URL to the Checkout Session.
        public var url: String?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String?
        /// When set, provides configuration for actions to take if this Checkout Session expires.
        public var afterExpiration: Stripe.Checkout.Session.AfterExpiration?
        /// Enables user redeemable promotion codes.
        public var allowPromotionCodes: Bool?
        /// Total of all items before discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total of all items after discounts and taxes are applied.
        public var amountTotal: Int?
        /// Details on the state of automatic tax for the session, including the status of the latest tax calculation.
        public var automaticTax: Stripe.Checkout.Session.AutomaticTax?
        /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
        public var billingAddressCollection: Stripe.Checkout.Session.Billing.Address.Collection?
        /// Results of `consent_collection` for this session.
        public var consent: Stripe.Checkout.Session.Consent?
        /// When set, provides configuration for the Checkout Session to gather active consent from customers.
        public var consentCollection: Stripe.Checkout.Session.Consent.Collection?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Currency conversion details for automatic currency conversion sessions
        public var currencyConversion: Stripe.Checkout.Session.Currency.Conversion?
        /// Collect additional information from your customer using custom fields. Up to 2 fields are supported.
        public var customFields: [Stripe.Checkout.Session.Custom.Field]?
        /// Display additional text for your customers using custom text.
        public var customText: Stripe.Checkout.Session.Custom.Text?
        /// Configure whether a Checkout Session creates a Customer when the Checkout Session completes.
        public var customerCreation: Stripe.Checkout.Session.Customer.Creation?
        /// The customer details including the customer’s tax exempt status and the customer’s tax IDs. Only present on Sessions in `payment` or `subscription` mode.
        public var customerDetails: Stripe.Checkout.Session.Customer.Details?
        /// The timestamp at which the Checkout Session will expire
        public var expiresAt: Date?
        /// ID of the invoice created by the Checkout Session, if it exists.
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var invoice:
            Stripe.Billing.Invoice.ID?
        /// Details on the state of invoice creation for the Checkout Session.
        public var invoiceCreation: Stripe.Checkout.Session.Invoice.Creation?
        /// Has the `value` true if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser’s locale is used.
        public var locale: Stripe.Checkout.Session.Locale?
        /// The ID of the Payment Link that created this Session.
        @ExpandableOf<Stripe.PaymentLink> public var paymentLink: Stripe.PaymentLink.ID?
        /// Configure whether a Checkout Session should collect a payment method.
        public var paymentMethodCollection: Stripe.Checkout.Session.PaymentMethod.Collection?
        /// Payment-method-specific configuration for the PaymentIntent or SetupIntent of this CheckoutSession.
        public var paymentMethodOptions: Stripe.Checkout.Session.PaymentMethod.Options?
        /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
        public var paymentMethodTypes: [String]?
        /// Details on the state of phone number collection for the session.
        public var phoneNumberCollection: Stripe_Types_Models.PhoneNumber.Collection?
        /// The ID of the original expired Checkout Session that triggered the recovery flow.
        public var recoveredFrom: String?
        /// The ID of the SetupIntent for Checkout Sessions in setup mode.
        @ExpandableOf<Stripe.Setup.Intent> public var setupIntent: Stripe.Setup.Intent.ID?
        /// When set, provides configuration for Checkout to collect a shipping address from a customer.
        public var shippingAddressCollection: Stripe.Checkout.Session.Shipping.Address.Collection?
        /// The ID of the Shipping.Rate for Checkout Sessions in payment mode.
        @ExpandableOf<Stripe.Products.Shipping.Rate> public var shippingRate
        /// The details of the customer cost of shipping, including the customer chosen Shipping.Rate.
        public var shippingCost: Stripe.Checkout.Session.Shipping.Cost?
        /// Shipping information for this Checkout Session.
        public var shippingDetails: ShippingLabel?
        /// The shipping rate options applied to this Session.
        public var shipppingOptions: [Stripe.Checkout.Session.Shipping.Option]?
        /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode.
        public var submitType: Stripe.Checkout.Session.Submit.`Type`?
        /// The ID of the subscription created if one or more plans were provided.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription:
            Stripe.Billing.Subscription.ID?
        /// Details on the state of tax ID collection for the session.
        public var taxIdCollection: Stripe.Checkout.Session.TaxId.Collection?
        /// Tax and discount details for the computed total amount.
        public var totalDetails: Stripe.Checkout.Session.Total.Details?

        public init(
            id: Stripe.Checkout.Session.ID,
            cancelUrl: String? = nil,
            clientReferenceId: String? = nil,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            customerEmail: String? = nil,
            lineItems: Stripe.Checkout.Session.LineItem.List? = nil,
            metadata: [String: String]? = nil,
            mode: Stripe.Checkout.Session.Mode? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            paymentStatus: Stripe.Checkout.Session.Payment.Status? = nil,
            status: Stripe.Checkout.Session.Status? = nil,
            successUrl: String? = nil,
            url: String? = nil,
            object: String? = nil,
            afterExpiration: Stripe.Checkout.Session.AfterExpiration? = nil,
            allowPromotionCodes: Bool? = nil,
            amountSubtotal: Int? = nil,
            amountTotal: Int? = nil,
            automaticTax: Stripe.Checkout.Session.AutomaticTax? = nil,
            billingAddressCollection: Stripe.Checkout.Session.Billing.Address.Collection? = nil,
            consent: Stripe.Checkout.Session.Consent? = nil,
            consentCollection: Stripe.Checkout.Session.Consent.Collection? = nil,
            created: Date,
            currencyConversion: Stripe.Checkout.Session.Currency.Conversion? = nil,
            customFields: [Stripe.Checkout.Session.Custom.Field]? = nil,
            customText: Stripe.Checkout.Session.Custom.Text? = nil,
            customerCreation: Stripe.Checkout.Session.Customer.Creation? = nil,
            customerDetails: Stripe.Checkout.Session.Customer.Details? = nil,
            expiresAt: Date? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            invoiceCreation: Stripe.Checkout.Session.Invoice.Creation? = nil,
            livemode: Bool? = nil,
            locale: Stripe.Checkout.Session.Locale? = nil,
            paymentLink: Stripe.PaymentLink.ID? = nil,
            paymentMethodCollection: Stripe.Checkout.Session.PaymentMethod.Collection? = nil,
            paymentMethodOptions: Stripe.Checkout.Session.PaymentMethod.Options? = nil,
            paymentMethodTypes: [String]? = nil,
            phoneNumberCollection: PhoneNumber.Collection? = nil,
            recoveredFrom: String? = nil,
            setupIntent: Stripe.Setup.Intent.ID? = nil,
            shippingAddressCollection: Stripe.Checkout.Session.Shipping.Address.Collection? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil,
            shippingCost: Stripe.Checkout.Session.Shipping.Cost? = nil,
            shippingDetails: ShippingLabel? = nil,
            shipppingOptions: [Stripe.Checkout.Session.Shipping.Option]? = nil,
            submitType: Stripe.Checkout.Session.Submit.`Type`? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            taxIdCollection: Stripe.Checkout.Session.TaxId.Collection? = nil,
            totalDetails: Stripe.Checkout.Session.Total.Details? = nil
        ) {
            self.id = id
            self.cancelUrl = cancelUrl
            self.clientReferenceId = clientReferenceId
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.customerEmail = customerEmail
            self.lineItems = lineItems
            self.metadata = metadata
            self.mode = mode
            self._paymentIntent = Expandable(id: paymentIntent)
            self.paymentStatus = paymentStatus
            self.status = status
            self.successUrl = successUrl
            self.url = url
            self.object = object
            self.afterExpiration = afterExpiration
            self.allowPromotionCodes = allowPromotionCodes
            self.amountSubtotal = amountSubtotal
            self.amountTotal = amountTotal
            self.automaticTax = automaticTax
            self.billingAddressCollection = billingAddressCollection
            self.consent = consent
            self.consentCollection = consentCollection
            self.created = created
            self.currencyConversion = currencyConversion
            self.customFields = customFields
            self.customText = customText
            self.customerCreation = customerCreation
            self.customerDetails = customerDetails
            self.expiresAt = expiresAt
            self._invoice = Expandable(id: invoice)
            self.invoiceCreation = invoiceCreation
            self.livemode = livemode
            self.locale = locale
            self._paymentLink = Expandable(id: paymentLink)
            self.paymentMethodCollection = paymentMethodCollection
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
            self.phoneNumberCollection = phoneNumberCollection
            self.recoveredFrom = recoveredFrom
            self._setupIntent = Expandable(id: setupIntent)
            self.shippingAddressCollection = shippingAddressCollection
            self._shippingRate = Expandable(id: shippingRate)
            self.shippingCost = shippingCost
            self.shippingDetails = shippingDetails
            self.shipppingOptions = shipppingOptions
            self.submitType = submitType
            self._subscription = Expandable(id: subscription)
            self.taxIdCollection = taxIdCollection
            self.totalDetails = totalDetails
        }
    }
}

extension Stripe.Checkout.Session {
    public typealias ID = Tagged<Self, String>
}
extension Stripe.Checkout.Session {
    public enum Custom {}
}

extension Stripe.Checkout.Session {
    public enum PaymentMethod {}
}

extension Stripe.Checkout.Session.Custom {
    public struct Field: Codable, Hashable, Sendable {
        /// Configuration for `type=dropdown` fields.
        public var dropdown: Stripe.Checkout.Session.Custom.Field.Dropdown?
        /// String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
        public var key: String?
        /// The label for the field, displayed to the customer.
        public var label: Stripe.Checkout.Session.Custom.Field.Label?
        /// Configuration for `type=numeric` fields.
        public var numeric: Stripe.Checkout.Session.Custom.Field.Numeric?
        /// Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
        public var optional: Bool?
        /// Configuration for `type=text` fields.
        public var text: Stripe.Checkout.Session.Custom.Field.Text?
        /// The type of the field.
        public var type: Stripe.Checkout.Session.Custom.Field.`Type`?

        public init(
            dropdown: Stripe.Checkout.Session.Custom.Field.Dropdown? = nil,
            key: String? = nil,
            label: Stripe.Checkout.Session.Custom.Field.Label? = nil,
            numeric: Stripe.Checkout.Session.Custom.Field.Numeric? = nil,
            optional: Bool? = nil,
            text: Stripe.Checkout.Session.Custom.Field.Text? = nil,
            type: Stripe.Checkout.Session.Custom.Field.`Type`? = nil
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

extension Stripe.Checkout.Session.Custom.Field {
    public struct Dropdown: Codable, Hashable, Sendable {
        /// The options available for the customer to select. Up to 200 options allowed
        public var options: [Stripe.Checkout.Session.Custom.Field.Dropdown.Option]?
        /// The option selected by the customer. This will be the `value` for the option.
        public var value: String?

        public init(
            options: [Stripe.Checkout.Session.Custom.Field.Dropdown.Option]? = nil,
            value: String? = nil
        ) {
            self.options = options
            self.value = value
        }
    }
}
extension Stripe.Checkout.Session.Custom.Field.Dropdown {
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

extension Stripe.Checkout.Session.Custom.Field {
    public struct Label: Codable, Hashable, Sendable {
        /// Custom text for the label, displayed to the customer. Up to 50 characters.
        public var custom: String?
        /// The type of the label.
        public var type: Stripe.Checkout.Session.Custom.Field.Label.`Type`?

        public init(
            custom: String? = nil,
            type: Stripe.Checkout.Session.Custom.Field.Label.`Type`? = nil
        ) {
            self.custom = custom
            self.type = type
        }
    }
}

extension Stripe.Checkout.Session.Custom.Field.Label {
    public enum `Type`: String, Codable, Sendable {
        /// Set a custom label for the field.
        case custom
    }
}

extension Stripe.Checkout.Session.Custom.Field {
    public struct Numeric: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer, containing only digits.
        public var value: String?

        private enum CodingKeys: String, CodingKey {
            case maximumLength = "maximum_length"
            case minimumLength = "mininum_length"
            case value
        }

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

extension Stripe.Checkout.Session.Custom.Field {
    public struct Text: Codable, Hashable, Sendable {
        /// The maximum character length constraint for the customer’s input.
        public var maximumLength: Int?
        /// The minimum character length requirement for the customer’s input.
        public var minimumLength: Int?
        /// The value entered by the customer.
        public var value: String?

        private enum CodingKeys: String, CodingKey {
            case maximumLength = "maximum_length"
            case minimumLength = "mininum_length"
            case value
        }

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

extension Stripe.Checkout.Session.Custom.Field {
    public enum `Type`: String, Codable, Sendable {
        /// Collect a string field from your customer.
        case text
        /// Collect a numbers-only field from your customer.
        case numeric
        /// Provide a list of options for your customer to select.
        case dropdown
    }
}

extension Stripe.Checkout.Session.Custom {
    public struct Text: Codable, Hashable, Sendable {
        /// Custom text that should be displayed alongside shipping address collection.
        public var shippingAddress: Stripe.Checkout.Session.Custom.Text.Shipping.Address?
        /// Custom text that should be displayed alongside the payment confirmation button.
        public var submit: Stripe.Checkout.Session.CustomTextSubmit?

        private enum CodingKeys: String, CodingKey {
            case shippingAddress = "shipping_address"
            case submit = "submit"
        }

        public init(
            shippingAddress: Stripe.Checkout.Session.Custom.Text.Shipping.Address? = nil,
            submit: Stripe.Checkout.Session.CustomTextSubmit? = nil
        ) {
            self.shippingAddress = shippingAddress
            self.submit = submit
        }
    }
}

extension Stripe.Checkout.Session.Custom.Text {
    public enum Shipping {}
}

extension Stripe.Checkout.Session.Custom.Text.Shipping {
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

extension Stripe.Checkout.Session {
    public struct CustomTextSubmit: Codable, Hashable, Sendable {
        /// Text may be up to 1000 characters in length.
        public var message: String?

        public init(
            message: String? = nil
        ) {
            self.message = message
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Customer {}
}

extension Stripe.Checkout.Session.Customer {
    public enum Creation: String, Codable, Sendable {
        /// The Checkout Session will only create a Customer if it is required for Session confirmation. Currently, only `subscription` mode Sessions require a Customer.
        case ifRequired = "if_required"
        /// The Checkout Session will always create a Customer when a Session confirmation is attempted.
        case always
    }
}

extension Stripe.Checkout.Session.Invoice {
    public struct Creation: Codable, Hashable, Sendable {
        /// Indicates whether invoice creation is enabled for the Checkout Session.
        public var enabled: Bool?
        /// Parameters passed when creating invoices for payment-mode Checkout Sessions.
        public var invoiceData: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data?

        public init(
            enabled: Bool? = nil,
            invoiceData: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data? = nil
        ) {
            self.enabled = enabled
            self.invoiceData = invoiceData
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Invoice {}
}

extension Stripe.Checkout.Session.Invoice.Creation {
    public enum Invoice {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice {
    public struct Data: Codable, Hashable, Sendable {
        /// The account tax IDs associated with the invoice
        @ExpandableCollection<Stripe.Tax.ID> public var accountTaxIds: [String]?
        /// Custom fields displayed on the invoice.
        public var customFields:
            [Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom.Fields]?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// Footer displayed on the invoice.
        public var footer: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// Options for invoice PDF rendering.
        public var renderingOptions:
            Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering.Options?

        public init(
            accountTaxIds: [String]? = nil,
            customFields: [Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom.Fields]? =
                nil,
            description: String? = nil,
            footer: String? = nil,
            metadata: [String: String]? = nil,
            renderingOptions: Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering
                .Options? =
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

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data {
    public enum Custom {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Custom {
    public struct Fields: Codable, Hashable, Sendable {
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
extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data {
    public enum Rendering {}
}

extension Stripe.Checkout.Session.Invoice.Creation.Invoice.Data.Rendering {
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

extension Stripe.Checkout.Session {
    public struct AfterExpiration: Codable, Hashable, Sendable {
        /// When set, configuration used to recover the Checkout Session on expiry.
        public var recovery: Stripe.Checkout.Session.AfterExpiration.Recovery?

        public init(
            recovery: Stripe.Checkout.Session.AfterExpiration.Recovery? = nil
        ) {
            self.recovery = recovery
        }
    }
}

extension Stripe.Checkout.Session.AfterExpiration {
    public struct Recovery: Codable, Hashable, Sendable {
        /// Enables user redeemable promotion codes on the recovered Checkout Sessions. Defaults to `false`
        public var allowPromotionCodes: Bool?
        /// If `true`, a recovery url will be generated to recover this Checkout Session if it expires before a transaction is completed. It will be attached to the Checkout Session object upon expiration.
        public var enabled: Bool?
        /// The timestamp at which the recovery URL will expire.
        public var expiresAt: Date?
        /// URL that creates a new Checkout Session when clicked that is a copy of this expired Checkout Session
        public var url: String?

        public init(
            allowPromotionCodes: Bool? = nil,
            enabled: Bool? = nil,
            expiresAt: Date? = nil,
            url: String? = nil
        ) {
            self.allowPromotionCodes = allowPromotionCodes
            self.enabled = enabled
            self.expiresAt = expiresAt
            self.url = url
        }
    }
}

extension Stripe.Checkout.Session {
    public struct AutomaticTax: Codable, Hashable, Sendable {
        /// Indicates whether automatic tax is enabled for the session.
        public var enabled: Bool?
        /// The status of the most recent automated tax calculation for this session.
        public var status: Stripe.Checkout.Session.AutomaticTax.Status?
    }
}

extension Stripe.Checkout.Session.AutomaticTax {
    public enum Status: String, Codable, Sendable {
        /// The location details entered by the customer aren’t valid or don’t provide enough location information to accurately determine tax rates.
        case requiresLocationInputs = "requires_location_inputs"
        /// Stripe successfully calculated tax automatically for this session.
        case complete
        /// The Stripe Tax service failed.
        case failed
    }
}

extension Stripe.Checkout.Session {
    public enum Billing {}
}

extension Stripe.Checkout.Session.Billing {
    public enum Address {}
}

extension Stripe.Checkout.Session.Billing.Address {
    public enum Collection: String, Codable, Sendable {
        /// Checkout will only collect the billing address when necessary. When using `automatic_tax`, Checkout will collect the minimum number of fields required for tax calculation.
        case auto
        /// Checkout will always collect the customer’s billing address.
        case required
    }
}

extension Stripe.Checkout.Session {
    public struct Consent: Codable, Hashable, Sendable {
        /// If `opt_in`, the customer consents to receiving promotional communications from the merchant about this Checkout Session.
        public var promotions: String?
        /// If `accepted`, the customer in this Checkout Session has agreed to the merchant’s terms of service.
        public var termsOfService: Stripe.Checkout.Session.Consent.TermsOfService?

        public init(
            promotions: String? = nil,
            termsOfService: Stripe.Checkout.Session.Consent.TermsOfService? = nil
        ) {
            self.promotions = promotions
            self.termsOfService = termsOfService
        }
    }
}

extension Stripe.Checkout.Session.Consent {
    public enum TermsOfService: String, Codable, Sendable {
        /// The customer has accepted the specified terms of service agreement.
        case accepted
    }
}

extension Stripe.Checkout.Session.Consent {
    public struct Collection: Codable, Hashable, Sendable {
        /// If set to `auto`, enables the collection of customer consent for promotional communications. The Checkout Session will determine whether to display an option to opt into promotional communication from the merchant depending on the customer’s locale. Only available to US merchants.
        public var promotions: String?
        /// If set to `required`, it requires customers to accept the terms of service before being able to pay.
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

extension Stripe.Checkout.Session {
    public typealias Currency = Stripe.Currency
}

extension Stripe.Checkout.Session.Currency {
    public struct Conversion: Codable, Hashable, Sendable {
        /// Total of all items in source currency before discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total of all items in source currency after discounts and taxes are applied.
        public var amountTotal: Int?
        /// Exchange rate used to convert source currency amounts to customer currency amounts
        public var fxRate: String?
        /// Creation currency of the CheckoutSession before localization
        public var sourceCurrency: Stripe.Currency?

        public init(
            amountSubtotal: Int? = nil,
            amountTotal: Int? = nil,
            fxRate: String? = nil,
            sourceCurrency: Stripe.Currency? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTotal = amountTotal
            self.fxRate = fxRate
            self.sourceCurrency = sourceCurrency
        }
    }
}

extension Stripe.Checkout.Session.Customer {
    public struct Details: Codable, Hashable, Sendable {
        /// The customer’s address after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        public var address: Address?
        /// The customer’s email at time of checkout.
        public var email: String?
        /// The customer’s name after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
        public var name: String?
        /// The customer’s phone number at the time of checkout
        public var phone: String?
        /// The customer’s tax exempt status at time of checkout.
        public var taxExempt: String?
        /// The customer’s tax IDs at time of checkout.
        public var taxIds: [Stripe.Checkout.Session.Customer.Details.TaxId]?

        public init(
            address: Address? = nil,
            email: String? = nil,
            name: String? = nil,
            phone: String? = nil,
            taxExempt: String? = nil,
            taxIds: [Stripe.Checkout.Session.Customer.Details.TaxId]? = nil
        ) {
            self.address = address
            self.email = email
            self.name = name
            self.phone = phone
            self.taxExempt = taxExempt
            self.taxIds = taxIds
        }
    }
}

extension Stripe.Checkout.Session.Customer.Details {
    public struct TaxId: Codable, Hashable, Sendable {
        /// The type of the tax ID.
        public var type: Stripe.Tax.ID.`Type`
        /// The value of the tax ID.
        public var value: String?

        public init(
            type: Stripe.Tax.ID.`Type`,
            value: String? = nil
        ) {
            self.type = type
            self.value = value
        }
    }
}

extension Stripe.Checkout.Session {

}
extension Stripe.Checkout.Session {
    public struct LineItem: Codable, Hashable, Sendable {
        /// Unique identifier for the object.
        public var id: Stripe.Checkout.Session.ID
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
        public var discounts: [Stripe.Checkout.Session.LineItem.Discount]?
        /// The price used to generate the line item.
        public var price: Stripe.Products.Price?
        /// The quantity of products being purchased.
        public var quantity: Int?
        /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
        public var taxes: [Stripe.Checkout.Session.LineItem.Tax]?

        public init(
            id: Stripe.Checkout.Session.ID,
            object: String,
            amountDiscount: Int? = nil,
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            discounts: [Stripe.Checkout.Session.LineItem.Discount]? = nil,
            price: Stripe.Products.Price? = nil,
            quantity: Int? = nil,
            taxes: [Stripe.Checkout.Session.LineItem.Tax]? = nil
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

extension Stripe.Checkout.Session.LineItem {
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

extension Stripe.Checkout.Session.LineItem {
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

extension Stripe.Checkout.Session.LineItem {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Checkout.Session.LineItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Checkout.Session.LineItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Locale: String, Codable, Sendable {
        case auto = "auto"
        case bg = "bg"
        case cs = "cs"
        case da = "da"
        case de = "de"
        case el = "el"
        case en = "en"
        case enGB = "en-GB"
        case es = "es"
        case es419 = "es-419"
        case et = "et"
        case fi = "fi"
        case fil = "fil"
        case fr = "fr"
        case frCA = "fr-CA"
        case hr = "hr"
        case hu = "hu"
        case id = "id"
        case it = "it"
        case ja = "ja"
        case ko = "ko"
        case lt = "lt"
        case lv = "lv"
        case ms = "ms"
        case mt = "mt"
        case nb = "nb"
        case nl = "nl"
        case pl = "pl"
        case pt = "pt"
        case ptBR = "pt-BR"
        case ro = "ro"
        case ru = "ru"
        case sk = "sk"
        case sl = "sl"
        case sv = "sv"
        case th = "th"
        case tr = "tr"
        case vi = "vi"
        case zh = "zh"
        case zhHK = "zh-HK"
        case zhTW = "zh-TW"
    }
}

extension Stripe.Checkout.Session {
    public enum Mode: String, Codable, Sendable {
        /// Accept one-time payments for cards, iDEAL, and more.
        case payment
        /// Save payment details to charge your customers later.
        case setup
        /// Use Stripe Billing to set up fixed-price subscriptions.
        case subscription
    }
}

extension Stripe.Checkout.Session.PaymentMethod {
    public enum Collection: String, Codable, Sendable {
        /// The Checkout Session will always collect a PaymentMethod.
        case always
        /// The Checkout Session will only collect a PaymentMethod if there is an amount due.
        case ifRequired = "if_required"
    }
}

extension Stripe.Checkout.Session {
    public enum Shipping {}
}

extension Stripe.Checkout.Session.Shipping {
    public enum Address {}
}

extension Stripe.Checkout.Session.Shipping.Address {
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

extension Stripe.Checkout.Session.Shipping {
    public struct Cost: Codable, Hashable, Sendable {
        /// Total shipping cost before any discounts or taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total shipping cost after discounts and taxes are applied.
        public var amountTotal: Int?
        /// The ID of the Shipping.Rate for this order.
        @ExpandableOf<Stripe.Products.Shipping.Rate> public var shippingRate
        /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, expand the `taxes` field.
        public var taxes: [Stripe.Checkout.Session.Shipping.Cost.Taxes]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil,
            taxes: [Stripe.Checkout.Session.Shipping.Cost.Taxes]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

extension Stripe.Checkout.Session.Shipping.Cost {
    public struct Taxes: Codable, Hashable, Sendable {
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

extension Stripe.Checkout.Session.Shipping {
    public struct Option: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var shippingAmount: Int?
        /// The shipping rate.
        @Expandable<Stripe.Products.Shipping.Rate, Stripe.Products.Shipping.Rate.ID> public
            var shippingRate

        public init(
            shippingAmount: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil
        ) {
            self.shippingAmount = shippingAmount
            self._shippingRate = Expandable(id: shippingRate)
        }
    }
}

extension Stripe.Checkout.Session {
    public enum Submit {}
}

extension Stripe.Checkout.Session.Submit {
    public enum `Type`: String, Codable, Sendable {
        case auto
        case book
        case donate
        case pay
    }
}

extension Stripe.Checkout.Session {
    public enum Status: String, Codable, Sendable {
        /// The checkout session is still in progress. Payment processing has not started
        case open
        /// The checkout session is complete. Payment processing may still be in progress
        case complete
        /// The checkout session has expired. No further processing will occur
        case expired
    }
}

extension Stripe.Checkout.Session {
    public enum Total {}
}

extension Stripe.Checkout.Session.Total {
    public struct Details: Codable, Hashable, Sendable {
        /// This is the sum of all the line item discounts.
        public var amountDiscount: Int?
        /// This is the sum of all the line item shipping amounts.
        public var amountShipping: Int?
        /// This is the sum of all the line item tax amounts.
        public var amountTax: Int?
        /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
        public var breakdown: Stripe.Checkout.Session.Total.Details.Breakdown?

        public init(
            amountDiscount: Int? = nil,
            amountShipping: Int? = nil,
            amountTax: Int? = nil,
            breakdown: Stripe.Checkout.Session.Total.Details.Breakdown? = nil
        ) {
            self.amountDiscount = amountDiscount
            self.amountShipping = amountShipping
            self.amountTax = amountTax
            self.breakdown = breakdown
        }
    }
}

extension Stripe.Checkout.Session.Total.Details {
    public struct Breakdown: Codable, Hashable, Sendable {
        /// The aggregated discounts.
        public var discounts: [Stripe.Checkout.Session.Total.Details.Breakdown.Discount]?
        /// The aggregated tax amounts by rate.
        public var taxes: [Stripe.Checkout.Session.Total.Details.Breakdown.Tax]?
    }
}

extension Stripe.Checkout.Session.Total.Details.Breakdown {
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

extension Stripe.Checkout.Session.Total.Details.Breakdown {
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

extension Stripe.Checkout.Session {
    public enum Payment {}
}

extension Stripe.Checkout.Session.Payment {
    public enum Status: String, Codable, Sendable {
        /// The payment funds are available in your account.
        case paid
        /// The payment funds are not yet available in your account.
        case unpaid
        /// The Checkout Session is in setup mode and doesn’t require a payment at this time.
        case noPaymentRequired = "no_payment_required"
    }
}

extension Stripe.Checkout.Session {
    public enum TaxId {}
}

extension Stripe.Checkout.Session.TaxId {
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

extension Stripe.Checkout.Session {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Checkout.Session]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Checkout.Session]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
