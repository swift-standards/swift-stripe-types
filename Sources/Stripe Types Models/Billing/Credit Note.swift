//
//  CreditNote.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/credit_notes/object.md

/// The [Credit Note Object](https://stripe.com/docs/api/credit_notes/object) .
extension Stripe.Billing.Credit {
    public struct Note: Codable, Hashable, Sendable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// ID of the invoice.
        @Expandable<Stripe.Billing.Invoice, Stripe.Billing.Invoice.ID> public var invoice:
            Stripe.Billing.Invoice.ID?
        /// Line items that make up the credit note
        public var lines: Note.LineItem.List?
        /// Customer-facing text that appears on the credit note PDF.
        public var memo: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
        public var reason: Note.Reason?
        /// Status of this credit note, one of issued or void. Learn more about [voiding credit notes](https://stripe.com/docs/billing/invoices/credit-notes#voiding).
        public var status: Note.Status?
        /// The integer amount in `cents` representing the amount of the credit note, excluding tax and discount.
        public var subtotal: Int?
        /// The integer amount in `cents` representing the total amount of the credit note, including tax and discount.
        public var total: Int?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The integer amount in cents representing the total amount of the credit note.
        public var amount: Int?
        /// This is the sum of all the shipping amounts.
        public var amountShipping: Int?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// ID of the customer.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// Customer balance transaction related to this credit note.
        @ExpandableOf<Stripe.Billing.Customer.Balance.Transaction> public
            var customerBalanceTransaction: Stripe.Billing.Customer.Balance.Transaction.ID?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// A unique number that identifies this particular credit note and appears on the PDF of the credit note and its associated invoice.
        public var number: String?
        /// Amount that was credited outside of Stripe.
        public var outOfBandAmount: Int?
        /// The link to download the PDF of the credit note.
        public var pdf: String?
        /// Refund related to this credit note.
        @ExpandableOf<Stripe.Refunds.Refund> public var refund: Stripe.Refunds.Refund.ID?
        /// The details of the cost of shipping, including the Shipping.Rate applied to the invoice.
        public var shippingCost: Note.Shipping.Cost?
        /// The integer amount in cents representing the amount of the credit note, excluding all tax and invoice level discounts.
        public var subtotalExcludingTax: Int?
        /// The aggregate amounts calculated per tax rate for all line items.
        public var taxAmounts: [Note.Tax.Amount]?
        /// The integer amount in cents representing the total amount of the credit note, excluding tax, but including discounts.
        public var totalExcludingTax: Int?
        /// Type of this credit note, one of `post_payment` or `pre_payment`. A `pre_payment` credit note means it was issued when the invoice was open. A `post_payment` credit note means it was issued when the invoice was paid.
        public var type: Note.`Type`?
        /// The time that the credit note was voided.
        public var voidedAt: Date?

        public init(
            id: ID? = nil,
            currency: Stripe.Currency? = nil,
            invoice: Stripe.Billing.Invoice.ID? = nil,
            lines: Note.LineItem.List? = nil,
            memo: String? = nil,
            metadata: [String: String]? = nil,
            reason: Note.Reason? = nil,
            status: Note.Status? = nil,
            subtotal: Int? = nil,
            total: Int? = nil,
            object: String,
            amount: Int? = nil,
            amountShipping: Int? = nil,
            created: Date,
            customer: Stripe.Customers.Customer.ID? = nil,
            customerBalanceTransaction: Stripe.Billing.Customer.Balance.Transaction.ID? = nil,
            livemode: Bool? = nil,
            number: String? = nil,
            outOfBandAmount: Int? = nil,
            pdf: String? = nil,
            refund: Stripe.Refunds.Refund.ID? = nil,
            shippingCost: Note.Shipping.Cost? = nil,
            subtotalExcludingTax: Int? = nil,
            taxAmounts: [Note.Tax.Amount]? = nil,
            totalExcludingTax: Int? = nil,
            type: Note.`Type`? = nil,
            voidedAt: Date? = nil
        ) {
            self.id = id
            self.currency = currency
            self._invoice = Expandable(id: invoice)
            self.lines = lines
            self.memo = memo
            self.metadata = metadata
            self.reason = reason
            self.status = status
            self.subtotal = subtotal
            self.total = total
            self.object = object
            self.amount = amount
            self.amountShipping = amountShipping
            self.created = created
            self._customer = Expandable(id: customer)
            self._customerBalanceTransaction = Expandable(id: customerBalanceTransaction)
            self.livemode = livemode
            self.number = number
            self.outOfBandAmount = outOfBandAmount
            self.pdf = pdf
            self._refund = Expandable(id: refund)
            self.shippingCost = shippingCost
            self.subtotalExcludingTax = subtotalExcludingTax
            self.taxAmounts = taxAmounts
            self.totalExcludingTax = totalExcludingTax
            self.type = type
            self.voidedAt = voidedAt
        }
    }
}

extension Stripe.Billing.Credit.Note {
    public enum Reason: String, Codable, Sendable {
        case duplicate
        case fraudulent
        case orderChange = "order_change"
        case productUnsatisfactory = "product_unsatisfactory"
    }
}

extension Stripe.Billing.Credit.Note {
    public enum Status: String, Codable, Sendable {
        case issued
        case void
    }
}

extension Stripe.Billing.Credit.Note {
    public enum Shipping {}
}

extension Stripe.Billing.Credit.Note.Shipping {
    public struct Cost: Codable, Hashable, Sendable {
        /// Total shipping cost before any taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
        public var amountTax: Int?
        /// Total shipping cost after taxes are applied.
        public var amountTotal: Int?
        /// The ID of the Shipping.Rate for this invoice.
        @Expandable<Stripe.Products.Shipping.Rate, String> public var shippingRate: String?
        /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `taxes` field.
        public var taxes: [Cost.Tax]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: String? = nil,
            taxes: [Cost.Tax]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

extension Stripe.Billing.Credit.Note.Shipping.Cost {
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

extension Stripe.Billing.Credit.Note {
    public enum Tax {}
}

extension Stripe.Billing.Credit.Note.Tax {
    public struct Amount: Codable, Hashable, Sendable {
        /// The amount, in cents, of the tax.
        public var amount: Int?
        /// Whether this tax amount is inclusive or exclusive.
        public var inclusive: Bool?
        /// The tax rate that was applied to get this tax amount.
        @ExpandableOf<Stripe.Tax.Rate> public var taxRate: Stripe.Tax.Rate.ID?

        public init(
            amount: Int? = nil,
            inclusive: Bool? = nil,
            taxRate: Stripe.Tax.Rate.ID? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self._taxRate = Expandable(id: taxRate)
        }
    }
}

extension Stripe.Billing.Credit.Note {
    public enum `Type`: String, Codable, Sendable {
        case postPayment = "post_payment"
        case prePayment = "pre_payment"
    }
}

extension Stripe.Billing.Credit.Note {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Billing.Credit.Note]?
        public var hasMore: Bool?
        public var url: String?

        public init(
            object: String,
            data: [Stripe.Billing.Credit.Note]? = nil,
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
