//
//  swift
//
//
//  Created by Andrew Edwards on 1/2/20.
//

import Foundation
import Stripe_Types_Shared

// https://docs.stripe.com/api/subscription_schedules/object.md

extension Stripe.Billing.Subscription {
    /// The [Schedule Object](https://stripe.com/docs/api/subscription_schedules/object)
    public struct Schedule: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>
        /// Unique identifier for the object.
        public var id: ID
        /// Object representing the start and end dates for the current phase of the subscription schedule, if it is active.
        public var currentPhase: CurrentPhase?
        /// ID of the customer who owns the subscription schedule.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// Configuration for the subscription schedule’s phases.
        public var phases: [Phase]?
        /// The present status of the subscription schedule. Possible values are `not_started`, `active`, `completed`, `released`, and `canceled`. You can read more about the different states in our behavior guide.
        public var status: Status?
        /// ID of the subscription managed by the subscription schedule.
        @ExpandableOf<Stripe.Billing.Subscription> public var subscription:
            Stripe.Billing.Subscription.ID?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// ID of the Connect Application that created the schedule.
        public var application: String?
        /// Time at which the subscription schedule was canceled. Measured in seconds since the Unix epoch.
        public var canceledAt: Date?
        /// Time at which the subscription schedule was completed. Measured in seconds since the Unix epoch.
        public var completedAt: Date?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Object representing the subscription schedule’s default settings.
        public var defaultSettings: DefaultSettings?
        /// Behavior of the subscription schedule and underlying subscription when it ends.
        public var endBehavior: EndBehavior?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// Time at which the subscription schedule was released. Measured in seconds since the Unix epoch.
        public var releasedAt: Date?
        /// ID of the subscription once managed by the subscription schedule (if it is released).
        public var releasedSubscription: Stripe.Billing.Subscription.ID?
        /// ID of the test clock this subscription schedule belongs to.
        @ExpandableOf<Stripe.Billing.TestClocks.TestClock> public var testClock:
            Stripe.Billing.TestClocks.TestClock.ID?

        public init(
            id: ID,
            currentPhase: CurrentPhase? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            metadata: [String: String]? = nil,
            phases: [Phase]? = nil,
            status: Status? = nil,
            subscription: Stripe.Billing.Subscription.ID? = nil,
            object: String,
            application: String? = nil,
            canceledAt: Date? = nil,
            completedAt: Date? = nil,
            created: Date,
            defaultSettings: DefaultSettings? = nil,
            endBehavior: EndBehavior? = nil,
            livemode: Bool? = nil,
            releasedAt: Date? = nil,
            releasedSubscription: Stripe.Billing.Subscription.ID? = nil,
            testClock: Stripe.Billing.TestClocks.TestClock.ID? = nil
        ) {
            self.id = id
            self.currentPhase = currentPhase
            self._customer = Expandable(id: customer)
            self.metadata = metadata
            self.phases = phases
            self.status = status
            self._subscription = Expandable(id: subscription)
            self.object = object
            self.application = application
            self.canceledAt = canceledAt
            self.completedAt = completedAt
            self.created = created
            self.defaultSettings = defaultSettings
            self.endBehavior = endBehavior
            self.livemode = livemode
            self.releasedAt = releasedAt
            self.releasedSubscription = releasedSubscription
            self._testClock = Expandable(id: testClock)
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct CurrentPhase: Codable, Hashable, Sendable {
        /// The end of this phase of the subscription schedule.
        public var endDate: Date?
        /// The start of this phase of the subscription schedule.
        public var startDate: Date?

        public init(
            endDate: Date? = nil,
            startDate: Date? = nil
        ) {
            self.endDate = endDate
            self.startDate = startDate
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct DefaultSettings: Codable, Hashable, Sendable {
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account during this phase of the schedule.
        public var applicationFeePercent: Float?
        /// Default settings for automatic tax computation.
        public var automaticTax: DefaultSettingsAutomaticTax?
        /// Possible values are `phase_start` or `automatic`. If `phase_start` then billing cycle anchor of the subscription is set to the start of the phase when entering the phase. If `automatic` then the billing cycle anchor is automatically modified as needed when entering the phase. For more information, see the billing cycle documentation.
        public var billingCycleAnchor: BillingCycleAnchor?
        /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
        public var billingThresholds: DefaultSettingsBillingThresholds?
        /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay the underlying subscription at the end of each billing cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
        public var collectionMethod: CollectionMethod?
        /// ID of the default payment method for the subscription schedule. If not set, invoices will use the default payment method in the customer’s invoice settings.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var defaultPaymentMethod:
            Stripe.PaymentMethods.PaymentMethod.ID?
        /// Subscription description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
        public var description: String?
        /// The subscription schedule’s default invoice settings.
        public var invoiceSettings: InvoiceSettings?
        /// The account (if any) the charge was made on behalf of for charges associated with the schedule’s subscription. See the Connect documentation for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
        public var transferData: TransferData?

        public init(
            applicationFeePercent: Float? = nil,
            automaticTax: DefaultSettingsAutomaticTax? = nil,
            billingCycleAnchor: BillingCycleAnchor? = nil,
            billingThresholds: DefaultSettingsBillingThresholds? = nil,
            collectionMethod: CollectionMethod? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            description: String? = nil,
            invoiceSettings: InvoiceSettings? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            transferData: TransferData? = nil
        ) {
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingCycleAnchor = billingCycleAnchor
            self.billingThresholds = billingThresholds
            self.collectionMethod = collectionMethod
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self.description = description
            self.invoiceSettings = invoiceSettings
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.transferData = transferData
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct DefaultSettingsAutomaticTax: Codable, Hashable, Sendable {
        /// Whether Stripe automatically computes tax on invoices created during this phase.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    @Cases
    public enum CollectionMethod: String, Codable, Sendable {
        case chargeAutomatically = "charge_automatically"
        case sendInvoice = "send_invoice"
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public enum EndBehavior: String, Codable, Sendable {
        case release
        case cancel
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct DefaultSettingsBillingThresholds: Codable, Hashable, Sendable {
        /// Monetary threshold that triggers the subscription to create an invoice
        public var amountGte: Int?
        /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be `true` if the subscription contains items with plans that have `aggregate_usage=last_ever`.
        public var resetBillingCycleAnchor: Bool?

        public init(
            amountGte: Int? = nil,
            resetBillingCycleAnchor: Bool? = nil
        ) {
            self.amountGte = amountGte
            self.resetBillingCycleAnchor = resetBillingCycleAnchor
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct InvoiceSettings: Codable, Hashable, Sendable {
        /// Number of days within which a customer must pay invoices generated by this subscription schedule. This value will be `null` for subscription schedules where `billing=charge_automatically`.
        public var daysUntilDue: Int?

        private enum CodingKeys: String, CodingKey {
            case daysUntilDue = "days_until_due"
        }

        public init(
            daysUntilDue: Int? = nil
        ) {
            self.daysUntilDue = daysUntilDue
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct TransferData: Codable, Hashable, Sendable {
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
        public var amountPercent: Int?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        public init(
            amountPercent: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amountPercent = amountPercent
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct Phase: Codable, Hashable, Sendable {
        /// A list of prices and quantities that will generate invoice items appended to the first invoice for this phase.
        public var addInvoiceItems: [PhaseAddInvoiceItem]?
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account during this phase of the schedule.
        public var applicationFeePercent: Float?
        /// Automatic tax settings for this phase.
        public var automaticTax: PhaseAutomaticTax?
        /// Possible values are `phase_start` or `automatic`. If `phase_start` then billing cycle anchor of the subscription is set to the start of the phase when entering the phase. If automatic then the billing cycle anchor is automatically modified as needed when entering the phase. For more information, see the billing cycle documentation.
        public var billingCycleAnchor: BillingCycleAnchor?
        /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
        public var billingThresholds: DefaultSettingsBillingThresholds?
        /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay the underlying subscription at the end of each billing cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
        public var collectionMethod: CollectionMethod?
        /// ID of the coupon to use during this phase of the subscription schedule.
        @ExpandableOf<Stripe.Products.Coupon> public var coupon
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// ID of the default payment method for the subscription schedule. It must belong to the customer associated with the subscription schedule. If not set, invoices will use the default payment method in the customer’s invoice settings.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var defaultPaymentMethod:
            Stripe.PaymentMethods.PaymentMethod.ID?
        /// The default tax rates to apply to the subscription during this phase of the subscription schedule.
        public var defaultTaxRates: [Stripe.Tax.Rate]?
        /// Subscription description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
        public var description: String?
        /// The end of this phase of the subscription schedule.
        public var endDate: Date?
        /// The subscription schedule’s default invoice settings.
        public var invoiceSettings: InvoiceSettings?
        /// Subscription items to configure the subscription to during this phase of the subscription schedule.
        public var items: [PhaseItem]?
        /// Set of key-value pairs that you can attach to a phase. Metadata on a schedule’s phase will update the underlying subscription’s metadata when the phase is entered. Updating the underlying subscription’s metadata directly will not affect the current phase’s metadata.
        public var metadata: [String: String]?
        /// The account (if any) the charge was made on behalf of for charges associated with the schedule’s subscription. See the Connect documentation for details.
        @ExpandableOf<Stripe.Connect.Account> public var onBehalfOf: Stripe.Connect.Account.ID?
        /// Controls whether or not the subscription schedule will prorate when transitioning to this phase. Values are `create_prorations` and `none`.
        public var prorationBehavior: Phase.ProrationBehavior?
        /// The start of this phase of the subscription schedule.
        public var startDate: Date?
        /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
        public var transferData: PhaseTransferData?
        /// When the trial ends within the phase.
        public var trialEnd: Date?

        public init(
            addInvoiceItems: [PhaseAddInvoiceItem]? = nil,
            applicationFeePercent: Float? = nil,
            automaticTax: PhaseAutomaticTax? = nil,
            billingCycleAnchor: BillingCycleAnchor? = nil,
            billingThresholds: DefaultSettingsBillingThresholds? = nil,
            collectionMethod: CollectionMethod? = nil,
            coupon: Stripe.Products.Coupon.ID? = nil,
            currency: Stripe.Currency? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            defaultTaxRates: [Stripe.Tax.Rate]? = nil,
            description: String? = nil,
            endDate: Date? = nil,
            invoiceSettings: InvoiceSettings? = nil,
            items: [PhaseItem]? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: Stripe.Connect.Account.ID? = nil,
            prorationBehavior: Phase.ProrationBehavior? = nil,
            startDate: Date? = nil,
            transferData: PhaseTransferData? = nil,
            trialEnd: Date? = nil
        ) {
            self.addInvoiceItems = addInvoiceItems
            self.applicationFeePercent = applicationFeePercent
            self.automaticTax = automaticTax
            self.billingCycleAnchor = billingCycleAnchor
            self.billingThresholds = billingThresholds
            self.collectionMethod = collectionMethod
            self._coupon = Expandable(id: coupon)
            self.currency = currency
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self.endDate = endDate
            self.invoiceSettings = invoiceSettings
            self.items = items
            self.metadata = metadata
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.prorationBehavior = prorationBehavior
            self.startDate = startDate
            self.transferData = transferData
            self.trialEnd = trialEnd
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct PhaseAddInvoiceItem: Codable, Hashable, Sendable {
        /// ID of the price used to generate the invoice item.
        @ExpandableOf<Stripe.Products.Price> public var price: Stripe.Products.Price.ID?
        /// The quantity of the invoice item.
        public var quantity: Int?
        /// The tax rates which apply to the item. When set, the `default_tax_rates` do not apply to this item.
        public var taxRates: [Stripe.Tax.Rate]?

        public init(
            price: Stripe.Products.Price.ID? = nil,
            quantity: Int? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil
        ) {
            self._price = Expandable(id: price)
            self.quantity = quantity
            self.taxRates = taxRates
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct PhaseAutomaticTax: Codable, Hashable, Sendable {
        /// Whether Stripe automatically computes tax on invoices created during this phase.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct PhaseItem: Codable, Hashable, Sendable {
        /// Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period.
        public var billingThresholds: PhaseItemBillingThresholds?
        /// Set of key-value pairs that you can attach to an item. Metadata on this item will update the underlying subscription item’s metadata when the phase is entered.
        public var metadata: [String: String]?
        /// ID of the price to which the customer should be subscribed.
        @ExpandableOf<Stripe.Products.Price> public var price: Stripe.Products.Price.ID?
        /// Quantity of the plan to which the customer should be subscribed.
        public var quantity: Int?
        /// The tax rates which apply to this `phase_item`. When set, the `default_tax_rates` on the phase do not apply to this `phase_item`.
        public var taxRates: [Stripe.Tax.Rate]?

        public init(
            billingThresholds: PhaseItemBillingThresholds? = nil,
            metadata: [String: String]? = nil,
            price: Stripe.Products.Price.ID? = nil,
            quantity: Int? = nil,
            taxRates: [Stripe.Tax.Rate]? = nil
        ) {
            self.billingThresholds = billingThresholds
            self.metadata = metadata
            self._price = Expandable(id: price)
            self.quantity = quantity
            self.taxRates = taxRates
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct PhaseItemBillingThresholds: Codable, Hashable, Sendable {
        /// Usage threshold that triggers the subscription to create an invoice
        public var usageGte: Int?

        public init(
            usageGte: Int? = nil
        ) {
            self.usageGte = usageGte
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct PhaseTransferData: Codable, Hashable, Sendable {
        /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
        public var amountPercent: Int?
        /// The account where funds from the payment will be transferred to upon payment success.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?

        public init(
            amountPercent: Int? = nil,
            destination: Stripe.Connect.Account.ID? = nil
        ) {
            self.amountPercent = amountPercent
            self._destination = Expandable(id: destination)
        }
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public enum BillingCycleAnchor: String, Codable, Sendable {
        case phaseStart = "phase_start"
        case automatic
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public enum Status: String, Codable, Sendable {
        case notStarted = "not_started"
        case active
        case completed
        case released
        case canceled
    }
}

extension Stripe.Billing.Subscription.Schedule.Phase {
    public enum ProrationBehavior: String, Codable, Sendable {
        case createProrations = "create_prorations"
        case alwaysInvoice = "always_invoice"
        case none
    }
}

extension Stripe.Billing.Subscription.Schedule {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Billing.Subscription.Schedule]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Billing.Subscription.Schedule]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
