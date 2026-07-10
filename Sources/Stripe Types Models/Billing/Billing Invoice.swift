//
//  Invoice.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/invoices/object.md

/// The [Invoice Object](https://stripe.com/docs/api/invoices/object) .
extension Stripe.Billing {
    public struct Invoice: Codable, Hashable, Sendable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object. This property is always present unless the invoice is an upcoming invoice. See Retrieve an upcoming invoice for more details.
        public let id: ID?
        /// Controls whether Stripe will perform automatic collection of the invoice. When `false`, the invoice’s state will not automatically advance without an explicit action.
        public var autoAdvance: Bool?
        /// ID of the latest charge generated for this invoice, if any.
        @ExpandableOf<Stripe.Charges.Charge> public var charge
        /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions.
        public var collectionMethod: Stripe.Billing.Invoice.CollectionMethod?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// The ID of the customer who will be billed.
        @ExpandableOf<Stripe.Customers.Customer> public var customer
        /// An arbitrary string attached to the object. Often useful for displaying to users. Referenced as ‘memo’ in the Dashboard.
        public var description: String?
        /// The URL for the hosted invoice page, which allows customers to view and pay an invoice. If the invoice has not been finalized yet, this will be null.
        public var hostedInvoiceUrl: String?
        /// The individual line items that make up the invoice. lines is sorted as follows: (1) pending invoice items (including prorations) in reverse chronological order, (2) subscription items in reverse chronological order, and (3) invoice items added after invoice creation in chronological order.
        public var lines: Stripe.Billing.Invoice.LineItem.List?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The PaymentIntent associated with this invoice. The PaymentIntent is generated when the invoice is finalized, and can then be used to pay the invoice. Note that voiding an invoice will cancel the PaymentIntent.
        @ExpandableOf<Stripe.PaymentIntents.PaymentIntent> public var paymentIntent:
            Stripe.PaymentIntents.PaymentIntent.ID?
        /// End of the usage period during which invoice items were added to this invoice.
        public var periodEnd: Date?
        /// Start of the usage period during which invoice items were added to this invoice.
        public var periodStart: Date?
        /// The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`. [Learn more](https://stripe.com/docs/billing/invoices/workflow#workflow-overview)
        public var status: Stripe.Billing.Invoice.Status?
        /// The subscription that this invoice was prepared for, if any.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription
        /// Details about the subscription that created this invoice.
        public var subscriptionDetails: Stripe.Billing.Subscription.Details?
        /// Total after discount.
        public var total: Int?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// The country of the business associated with this invoice, most often the business creating the invoice.
        public var accountCountry: String?
        /// The public name of the business associated with this invoice, most often the business creating the invoice.
        public var accountName: String?
        /// The account tax IDs associated with the invoice. Only editable when the invoice is a draft.
        @ExpandableCollection<Stripe.Tax.ID> public var accountTaxIds: [String]?
        /// Final amount due at this time for this invoice. If the invoice’s total is smaller than the minimum charge amount, for example, or if there is account credit that can be applied to the invoice, the `amount_due` may be 0. If there is a positive `starting_balance` for the invoice (the customer owes money), the `amount_due` will also take that into account. The charge that gets generated for the invoice will be for the amount specified in `amount_due`.
        public var amountDue: Int?
        /// The amount, in cents, that was paid.
        public var amountPaid: Int?
        /// The amount remaining, in cents, that is due.
        public var amountRemanining: Int?
        /// This is the sum of all the shipping amounts.
        public var amountShipping: Int?
        /// ID of the Connect Application that created the invoice.
        public var application: String?
        /// The fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account when the invoice is paid.
        public var applicationFeeAmount: Int?
        /// Number of payment attempts made for this invoice, from the perspective of the payment retry schedule. Any payment attempt counts as the first attempt, and subsequently only automatic retries increment the attempt count. In other words, manual payment attempts after the first attempt do not affect the retry schedule.
        public var attemptCount: Int?
        /// Whether an attempt has been made to pay the invoice. An invoice is not attempted until 1 hour after the `invoice.created` webhook, for example, so you might not want to display that invoice as unpaid to your users.
        public var attempted: Bool?
        /// Settings and latest results for automatic tax lookup for this invoice.
        public var automaticTax: Stripe.Billing.Invoice.AutomaticTax?
        /// Indicates the reason why the invoice was created. `subscription_cycle` indicates an invoice created by a subscription advancing into a new period. `subscription_create` indicates an invoice created due to creating a subscription. `subscription_update` indicates an invoice created due to updating a subscription. `subscription` is set for all old invoices to indicate either a change to a subscription or a period advancement. `manual` is set for all invoices unrelated to a subscription (for example: created via the invoice editor). The `upcoming` value is reserved for simulated invoices per the upcoming invoice endpoint. `subscription_threshold` indicates an invoice created due to a billing threshold being reached.
        public var billingReason: Stripe.Billing.Invoice.BillingReason?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Custom fields displayed on the invoice.
        public var customFields: [Stripe.Billing.Invoice.CustomField]?
        /// The customer’s address. Until the invoice is finalized, this field will equal customer.address. Once the invoice is finalized, this field will no longer be updated.
        public var customerAddress: Address?
        /// The customer’s email. Until the invoice is finalized, this field will equal customer.email. Once the invoice is finalized, this field will no longer be updated.
        public var customerEmail: String?
        /// The customer’s name. Until the invoice is finalized, this field will equal customer.name. Once the invoice is finalized, this field will no longer be updated.
        public var customerName: String?
        /// The customer’s phone number. Until the invoice is finalized, this field will equal customer.phone. Once the invoice is finalized, this field will no longer be updated.
        public var customerPhone: String?
        /// The customer’s shipping information. Until the invoice is finalized, this field will equal customer.shipping. Once the invoice is finalized, this field will no longer be updated.
        public var customerShipping: ShippingLabel?
        /// The customer’s tax exempt status. Until the invoice is finalized, this field will equal `customer.tax_exempt`. Once the invoice is finalized, this field will no longer be updated.
        public var customerTaxExempt: String?
        /// The customer’s tax IDs. Until the invoice is finalized, this field will contain the same tax IDs as `customer.tax_ids`. Once the invoice is finalized, this field will no longer be updated.
        public var customerTaxIds: [Stripe.Billing.Invoice.CustomerTaxId]?
        /// ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription’s default payment method, if any, or to the default payment method in the customer’s invoice settings.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var defaultPaymentMethod
        /// ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription’s default source, if any, or to the customer’s default source.
        @DynamicExpandable<BankAccount, Card> public var defaultSource: String?
        /// The tax rates applied to this invoice, if any.
        public var defaultTaxRates: [Stripe.Tax.Rate]?
        /// The date on which payment for this invoice is due. This value will be `null` for invoices where `billing=charge_automatically`.
        public var dueDate: Date?
        /// Ending customer balance after the invoice is finalized. Invoices are finalized approximately an hour after successful webhook delivery or when payment collection is attempted for the invoice. If the invoice has not been finalized yet, this will be null.
        public var endingBalance: Int?
        /// Footer displayed on the invoice.
        public var footer: String?
        /// Details of the invoice that was cloned. See the revision documentation for more details.
        public var fromInvoice: Stripe.Billing.Invoice.FromInvoice?
        /// The link to download the PDF for the invoice. If the invoice has not been finalized yet, this will be null.
        public var invoicePdf: String?
        /// The error encountered during the previous attempt to finalize the invoice. This field is cleared when the invoice is successfully finalized.
        public var lastFinalizationError: Stripe.Billing.Invoice.LastFinalizationError?
        /// The ID of the most recent non-draft revision of this invoice
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var latestRevision
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// The time at which payment will next be attempted. This value will be `null` for invoices where `billing=send_invoice`.
        public var nextPaymentAttempt: Date?
        /// A unique, identifying string that appears on emails sent to the customer for this invoice. This starts with the customer’s unique invoice_prefix if it is specified.
        public var number: String?
        /// The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the Invoices with Connect documentation for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf
        /// Whether payment was successfully collected for this invoice. An invoice can be paid (most commonly) with a charge or with credit from the customer’s account balance.
        public var paid: Bool?
        /// Returns true if the invoice was manually marked paid, returns false if the invoice hasn’t been paid yet or was paid on Stripe.
        public var paidOutOfBand: Bool?
        /// Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
        public var paymentSettings: Stripe.Billing.Invoice.PaymentSettings?
        /// Total amount of all post-payment credit notes issued for this invoice.
        public var postPaymentCreditNotesAmount: Int?
        /// Total amount of all pre-payment credit notes issued for this invoice.
        public var prePaymentCreditNotesAmount: Int?
        /// The quote this invoice was generated from.
        @ExpandableOf<Stripe.Billing.Quote> public var quote
        /// This is the transaction number that appears on email receipts sent for this invoice.
        public var receiptNumber: String?
        /// Options for invoice PDF rendering.
        public var renderingOptions: Stripe.Billing.Invoice.RenderingOptions?
        /// The details of the cost of shipping, including the Shipping.Rate applied on the invoice.
        public var shippingCost: Stripe.Billing.Invoice.ShippingCost?
        /// Starting customer balance before the invoice is finalized. If the invoice has not been finalized yet, this will be the current customer balance.
        public var startingBalance: Int?
        /// Extra information about an invoice for the customer’s credit card statement.
        public var statementDescriptor: Stripe.StatementDescriptor?
        /// The timestamps at which the invoice status was updated.
        public var statusTransitions: Stripe.Billing.Invoice.StatusTransitions?
        /// Only set for upcoming invoices that preview prorations. The time used to calculate prorations.
        public var subscriptionProrationDate: Date?
        /// Total of all subscriptions, invoice items, and prorations on the invoice before any discount is applied.
        public var subtotal: Int?
        /// The integer amount in cents representing the subtotal of the invoice before any invoice level discount or tax is applied. Item discounts are already incorporated.
        public var subtotalExcludingTax: Int?
        /// The amount of tax on this invoice. This is the sum of all the tax amounts on this invoice.
        public var tax: Int?
        /// ID of the test clock this invoice belongs to.
        @ExpandableOf<Stripe.Billing.TestClocks.TestClock> public var testClock
        /// If `billing_reason` is set to `subscription_threshold` this returns more information on which threshold rules triggered the invoice.
        public var thresholdReason: Stripe.Billing.Invoice.ThresholdReason?
        /// The aggregate amounts calculated per discount across all line items.
        public var totalDiscountAmounts: [Stripe.Billing.Invoice.TotalDiscountAmount]?
        /// The integer amount in cents representing the total amount of the invoice including all discounts but excluding all tax.
        public var totalExcludingTax: Int?
        /// The aggregate amounts calculated per tax rate for all line items.
        public var totalTaxAmounts: [Stripe.Billing.Invoice.TotalTaxAmount]?
        /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to for the invoice.
        public var transferData: Stripe.Billing.Invoice.TransferData?
        /// The time at which webhooks for this invoice were successfully delivered (if the invoice had no webhooks to deliver, this will match `created`). Invoice payment is delayed until webhooks are delivered, or until all webhook delivery attempts have been exhausted.
        public var webhooksDeliveredAt: Date?

        public init(
            id: ID? = nil,
            autoAdvance: Bool? = nil,
            charge: Stripe.Charges.Charge.ID? = nil,
            collectionMethod: Stripe.Billing.Invoice.CollectionMethod? = nil,
            currency: Stripe.Currency? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            hostedInvoiceUrl: String? = nil,
            lines: Stripe.Billing.Invoice.LineItem.List? = nil,
            metadata: [String: String]? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            periodEnd: Date? = nil,
            periodStart: Date? = nil,
            status: Stripe.Billing.Invoice.Status? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            subscriptionDetails: Stripe.Billing.Subscription.Details? = nil,
            total: Int? = nil,
            object: String,
            accountCountry: String? = nil,
            accountName: String? = nil,
            accountTaxIds: [String]? = nil,
            amountDue: Int? = nil,
            amountPaid: Int? = nil,
            amountRemanining: Int? = nil,
            amountShipping: Int? = nil,
            application: String? = nil,
            applicationFeeAmount: Int? = nil,
            attemptCount: Int? = nil,
            attempted: Bool? = nil,
            automaticTax: Stripe.Billing.Invoice.AutomaticTax? = nil,
            billingReason: Stripe.Billing.Invoice.BillingReason? = nil,
            created: Date,
            customFields: [Stripe.Billing.Invoice.CustomField]? = nil,
            customerAddress: Address? = nil,
            customerEmail: String? = nil,
            customerName: String? = nil,
            customerPhone: String? = nil,
            customerShipping: ShippingLabel? = nil,
            customerTaxExempt: String? = nil,
            customerTaxIds: [Stripe.Billing.Invoice.CustomerTaxId]? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            defaultSource: String? = nil,
            defaultTaxRates: [Stripe.Tax.Rate]? = nil,
            dueDate: Date? = nil,
            endingBalance: Int? = nil,
            footer: String? = nil,
            fromInvoice: Stripe.Billing.Invoice.FromInvoice? = nil,
            invoicePdf: String? = nil,
            lastFinalizationError: Stripe.Billing.Invoice.LastFinalizationError? = nil,
            latestRevision: Stripe.Billing.Invoice.ID? = nil,
            livemode: Bool? = nil,
            nextPaymentAttempt: Date? = nil,
            number: String? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            paid: Bool? = nil,
            paidOutOfBand: Bool? = nil,
            paymentSettings: Stripe.Billing.Invoice.PaymentSettings? = nil,
            postPaymentCreditNotesAmount: Int? = nil,
            prePaymentCreditNotesAmount: Int? = nil,
            quote: Stripe.Billing.Quote.ID? = nil,
            receiptNumber: String? = nil,
            renderingOptions: Stripe.Billing.Invoice.RenderingOptions? = nil,
            shippingCost: Stripe.Billing.Invoice.ShippingCost? = nil,
            startingBalance: Int? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            statusTransitions: Stripe.Billing.Invoice.StatusTransitions? = nil,
            subscriptionProrationDate: Date? = nil,
            subtotal: Int? = nil,
            subtotalExcludingTax: Int? = nil,
            tax: Int? = nil,
            testClock: Stripe.Billing.TestClocks.TestClock.ID? = nil,
            thresholdReason: Stripe.Billing.Invoice.ThresholdReason? = nil,
            totalDiscountAmounts: [Stripe.Billing.Invoice.TotalDiscountAmount]? = nil,
            totalExcludingTax: Int? = nil,
            totalTaxAmounts: [Stripe.Billing.Invoice.TotalTaxAmount]? = nil,
            transferData: Stripe.Billing.Invoice.TransferData? = nil,
            webhooksDeliveredAt: Date? = nil
        ) {
            self.id = id
            self.autoAdvance = autoAdvance
            self._charge = Expandable(id: charge)
            self.collectionMethod = collectionMethod
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.description = description
            self.hostedInvoiceUrl = hostedInvoiceUrl
            self.lines = lines
            self.metadata = metadata
            self._paymentIntent = Expandable(id: paymentIntent)
            self.periodEnd = periodEnd
            self.periodStart = periodStart
            self.status = status
            self._subscription = Expandable(id: subscription)
            self.subscriptionDetails = subscriptionDetails
            self.total = total
            self.object = object
            self.accountCountry = accountCountry
            self.accountName = accountName
            self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
            self.amountDue = amountDue
            self.amountPaid = amountPaid
            self.amountRemanining = amountRemanining
            self.amountShipping = amountShipping
            self.application = application
            self.applicationFeeAmount = applicationFeeAmount
            self.attemptCount = attemptCount
            self.attempted = attempted
            self.automaticTax = automaticTax
            self.billingReason = billingReason
            self.created = created
            self.customFields = customFields
            self.customerAddress = customerAddress
            self.customerEmail = customerEmail
            self.customerName = customerName
            self.customerPhone = customerPhone
            self.customerShipping = customerShipping
            self.customerTaxExempt = customerTaxExempt
            self.customerTaxIds = customerTaxIds
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self._defaultSource = DynamicExpandable(id: defaultSource)
            self.defaultTaxRates = defaultTaxRates
            self.dueDate = dueDate
            self.endingBalance = endingBalance
            self.footer = footer
            self.fromInvoice = fromInvoice
            self.invoicePdf = invoicePdf
            self.lastFinalizationError = lastFinalizationError
            self._latestRevision = Expandable(id: latestRevision)
            self.livemode = livemode
            self.nextPaymentAttempt = nextPaymentAttempt
            self.number = number
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.paid = paid
            self.paidOutOfBand = paidOutOfBand
            self.paymentSettings = paymentSettings
            self.postPaymentCreditNotesAmount = postPaymentCreditNotesAmount
            self.prePaymentCreditNotesAmount = prePaymentCreditNotesAmount
            self._quote = Expandable(id: quote)
            self.receiptNumber = receiptNumber
            self.renderingOptions = renderingOptions
            self.shippingCost = shippingCost
            self.startingBalance = startingBalance
            self.statementDescriptor = statementDescriptor
            self.statusTransitions = statusTransitions
            self.subscriptionProrationDate = subscriptionProrationDate
            self.subtotal = subtotal
            self.subtotalExcludingTax = subtotalExcludingTax
            self.tax = tax
            self._testClock = Expandable(id: testClock)
            self.thresholdReason = thresholdReason
            self.totalDiscountAmounts = totalDiscountAmounts
            self.totalExcludingTax = totalExcludingTax
            self.totalTaxAmounts = totalTaxAmounts
            self.transferData = transferData
            self.webhooksDeliveredAt = webhooksDeliveredAt
        }
    }
}

extension Stripe.Billing.Subscription {
    public struct Details: Codable, Hashable, Sendable {
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        public init(
            metadata: [String: String]? = nil
        ) {
            self.metadata = metadata
        }
    }
}

extension Stripe.Billing.Invoice {
    public enum BillingReason: String, Codable, Sendable {
        case automatic
        case manual
        case subscription
        case subscriptionCreate = "subscription_create"
        case subscriptionCycle = "subscription_cycle"
        case subscriptionThreshold = "subscription_threshold"
        case subscriptionUpdate = "subscription_update"
        case upcoming
    }

    public enum CollectionMethod: String, Codable, Sendable {
        case chargeAutomatically = "charge_automatically"
        case sendInvoice = "send_invoice"
    }
}

extension Stripe.Billing.Invoice {
    public struct AutomaticTax: Codable, Hashable, Sendable {
        /// Whether Stripe automatically computes tax on this invoice. Note that incompatible invoice items (invoice items with manually specified tax rates, negative amounts, or t`ax_behavior=unspecified`) cannot be added to automatic tax invoices.
        public var enabled: Bool?
        /// The status of the most recent automated tax calculation for this invoice.
        public var statis: Stripe.Billing.Invoice.AutomaticTaxStatus?

        public init(
            enabled: Bool? = nil,
            statis: Stripe.Billing.Invoice.AutomaticTaxStatus? = nil
        ) {
            self.enabled = enabled
            self.statis = statis
        }
    }
}

extension Stripe.Billing.Invoice {
    public enum AutomaticTaxStatus: String, Codable, Sendable {
        /// The location details supplied on the customer aren’t valid or don’t provide enough location information to accurately determine tax rates for the customer.
        case requiresLocationInputs = "requires_location_inputs"
        /// Stripe successfully calculated tax automatically on this invoice.
        case complete
        /// The Stripe Tax service failed, please try again later.
        case failed
    }
}

extension Stripe.Billing.Invoice {
    public enum Reason: String, Codable, Sendable {
        case subscriptionCycle = "subscription_cycle"
        case subscriptionCreate = "subscription_create"
        case subscriptionUpdate = "subscription_update"
        case subscription
        case manual
        case upcoming
        case subscriptionThreshold = "subscription_threshold"
    }
}

extension Stripe.Billing.Invoice {
    public struct CustomField: Codable, Hashable, Sendable {
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

extension Stripe.Billing.Invoice {
    public struct CustomerTaxId: Codable, Hashable, Sendable {
        /// The type of the tax ID
        public var type: Stripe.Tax.ID.`Type`?
        /// The value of the tax ID.
        public var value: String?

        public init(
            type: Stripe.Tax.ID.`Type`? = nil,
            value: String? = nil
        ) {
            self.type = type
            self.value = value
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct FromInvoice: Codable, Hashable, Sendable {
        /// The relation between this invoice and the cloned invoice
        public var action: String?
        /// The invoice that was cloned.
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var invoice

        public init(
            action: String? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil
        ) {
            self.action = action
            self._invoice = Expandable(id: invoice)
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct LastFinalizationError: Codable, Hashable, Sendable {
        /// The type of error returned. One of `api_connection_error`, `api_error`, `authentication_error`, `card_error`, `idempotency_error`, `invalid_request_error`, or `rate_limit_error`.
        public var type: StripeError.Variant?
        /// For some errors that could be handled programmatically, a short string indicating the error code reported.
        public var code: StripeErrorCode?
        /// A URL to more information about the error code reported.
        public var docUrl: String?
        /// A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.
        public var message: String?
        /// If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.
        public var param: String?
        /// If the error is specific to the type of payment method, the payment method type that had a problem. This field is only populated for invoice-related errors.
        public var paymentMethodType: Stripe.PaymentMethods.PaymentMethod.`Type`?

        public init(
            type: StripeError.Variant? = nil,
            code: StripeErrorCode? = nil,
            docUrl: String? = nil,
            message: String? = nil,
            param: String? = nil,
            paymentMethodType: Stripe.PaymentMethods.PaymentMethod.`Type`? = nil
        ) {
            self.type = type
            self.code = code
            self.docUrl = docUrl
            self.message = message
            self.param = param
            self.paymentMethodType = paymentMethodType
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct PaymentSettings: Codable, Hashable, Sendable {
        /// ID of the mandate to be used for this invoice. It must correspond to the payment method used to pay the invoice, including the invoice’s `default_payment_method` or `default_source`, if set.
        public var defaultMandate: Stripe.Mandates.Mandate.ID?
        /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
        public var paymentMethodOptions:
            Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions?
        /// The list of payment method types (e.g. card) to provide to the invoice’s PaymentIntent. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your invoice template settings.
        public var paymentMethodTypes: [Stripe.PaymentMethods.PaymentMethod.`Type`]?

        public init(
            defaultMandate: Stripe.Mandates.Mandate.ID? = nil,
            paymentMethodOptions: Stripe.Billing.Invoice.PaymentSettings.PaymentMethodOptions? =
                nil,
            paymentMethodTypes: [Stripe.PaymentMethods.PaymentMethod.`Type`]? = nil
        ) {
            self.defaultMandate = defaultMandate
            self.paymentMethodOptions = paymentMethodOptions
            self.paymentMethodTypes = paymentMethodTypes
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct RenderingOptions: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct ShippingCost: Codable, Hashable, Sendable {
        /// Total shipping cost before any taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total shipping cost after taxes are applied.
        public var amountTotal: Int?
        /// The ID of the Shipping.Rate for this invoice
        @ExpandableOf<Stripe.Products.Shipping.Rate> public var shippingRate
        /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `taxes` field.
        public var taxes: [Stripe.Billing.Invoice.ShippingCost.Tax]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil,
            taxes: [Stripe.Billing.Invoice.ShippingCost.Tax]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Invoice.ShippingCost {
    public struct Tax: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        /// The tax rate applied.
        public var rate: Stripe.Tax.Rate?
        /// product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason: Stripe.Billing.Invoice.ShippingCost.Tax.TaxabilityReason?
        /// The amount on which tax is calculated, in cents.
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: Stripe.Billing.Invoice.ShippingCost.Tax.TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self.rate = rate
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }
    }
}

extension Stripe.Billing.Invoice.ShippingCost.Tax {
    public enum TaxabilityReason: String, Codable, Sendable {
        case vatExempt = "vat_exempt"
        case jurisdictionUnsupported = "jurisdiction_unsupported"
        case excludedTerritory = "excluded_territory"
        case standardRated = "standard_rated"
        case reducedRated = "reduced_rated"
        case zeroRated = "zero_rated"
        case reverseCharge = "reverse_charge"
        case customerExempt = "customer_exempt"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case portionStandardRated = "portion_standard_rated"
        case portionReducedRated = "portion_reduced_rated"
        case portionProductExempt = "portion_product_exempt"
        case taxableBasisReduced = "taxable_basis_reduced"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Invoice {
    public enum Status: String, Codable, Sendable {
        case draft
        case open
        case void
        case paid
        case uncollectible
    }
}

extension Stripe.Billing.Invoice {
    public struct StatusTransitions: Codable, Hashable, Sendable {
        /// The time that the invoice draft was finalized.
        public var finalizedAt: Date?
        /// The time that the invoice was marked uncollectible.
        public var markedUncollectableAt: Date?
        /// The time that the invoice was paid.
        public var paidAt: Date?
        /// The time that the invoice was voided.
        public var voidedAt: Date?

        public init(
            finalizedAt: Date? = nil,
            markedUncollectableAt: Date? = nil,
            paidAt: Date? = nil,
            voidedAt: Date? = nil
        ) {
            self.finalizedAt = finalizedAt
            self.markedUncollectableAt = markedUncollectableAt
            self.paidAt = paidAt
            self.voidedAt = voidedAt
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct ThresholdReason: Codable, Hashable, Sendable {
        /// The total invoice amount threshold boundary if it triggered the threshold invoice.
        public var amountGte: Int?
        /// Indicates which line items triggered a threshold invoice.
        public var itemReasons: [Stripe.Billing.Invoice.ThresholdReason.ItemReason]?

        public init(
            amountGte: Int? = nil,
            itemReasons: [Stripe.Billing.Invoice.ThresholdReason.ItemReason]? = nil
        ) {
            self.amountGte = amountGte
            self.itemReasons = itemReasons
        }
    }
}

extension Stripe.Billing.Invoice.ThresholdReason {
    public struct ItemReason: Codable, Hashable, Sendable {
        /// The IDs of the line items that triggered the threshold invoice.
        public var lineItemIds: [String]?
        /// The quantity threshold boundary that applied to the given line item.
        public var usageGte: Int?

        public init(
            lineItemIds: [String]? = nil,
            usageGte: Int? = nil
        ) {
            self.lineItemIds = lineItemIds
            self.usageGte = usageGte
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct TotalTaxAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int?
        /// Whether this tax amount is inclusive or exclusive.
        public var inclusive: Bool?
        /// The tax rate that was applied to get this tax amount.
        @ExpandableOf<Stripe.Tax.Rate> public var taxRate
        /// The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        public var taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason?
        /// The amount on which tax is calculated, in cents.
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            inclusive: Bool? = nil,
            taxRate: Stripe.Tax.Rate.ID? = nil,
            taxabilityReason: Stripe.Billing.Invoice.TotalTaxAmount.TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self._taxRate = Expandable(id: taxRate)
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }
    }
}

extension Stripe.Billing.Invoice.TotalTaxAmount {
    public enum TaxabilityReason: String, Codable, Sendable {
        /// Taxed at the standard rate.
        case standardRated = "standard_rated"
        /// Taxed at a reduced rate.
        case reducedRated = "reduced_rated"
        /// The transaction is taxed at a special rate of 0% or the transaction is exempt (but these exempt transactions still let you deduct the “input VAT” paid on your business purchases).
        case zeroRated = "zero_rated"
        /// No tax is applied as it is the responsibility of the buyer to account for tax in this case.
        case reverseCharge = "reverse_charge"
        /// No tax is applied as the customer is exempt from tax.
        case customerExempt = "customer_exempt"
        /// The product or service is nontaxable or exempt from tax.
        case productExempt = "product_exempt"
        /// The product or service is not taxed due to a sales tax holiday.
        case productExemptHoliday = "product_exempt_holiday"
        /// A portion of the price is taxed at the standard rate.
        case portionStandardRated = "portion_standard_rated"
        /// A portion of the price is taxed at a reduced rate.
        case portionReducedRated = "portion_reduced_rated"
        /// A portion of the price is exempt from tax.
        case portionProductExempt = "portion_product_exempt"
        /// A reduced amount of the price is subject to tax.
        case taxableBasisReduced = "taxable_basis_reduced"
        /// No tax is collected either because you are not registered to collect tax in this jurisdiction, or because the non-taxable product tax code (txcd_00000000) was used.
        case notCollecting = "not_collecting"
        /// No tax is imposed on this transaction.
        case notSubjectToTax = "not_subject_to_tax"
        /// No tax is applied as Stripe Tax does not support this jurisdiction or territory.
        case notSupported = "not_supported"
        /// The shipping cost tax rate is calculated as a weighted average of the other line items’ rates, weighted by their amounts.
        case proportionallyRated = "proportionally_rated"
    }
}

extension Stripe.Billing.Invoice {
    public struct TotalDiscountAmount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the discount.
        public var amount: Int?
        /// The discount that was applied to get this discount amount.
        @ExpandableOf<Stripe.Products.Discount> public var discount

        public init(
            amount: Int? = nil,
            discount: Stripe.Products.Discount.ID? = nil
        ) {
            self.amount = amount
            self._discount = Expandable(id: discount)
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct TransferData: Codable, Hashable, Sendable {
        /// The amount in cents that will be transferred to the destination account when the invoice is paid. By default, the entire amount is transferred to the destination.
        public var amount: Int?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination

        public init(
            amount: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amount = amount
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.Billing.Invoice {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Invoice]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Invoice]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
