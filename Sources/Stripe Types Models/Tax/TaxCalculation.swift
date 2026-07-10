//
//  TaxCalculation.swift
//  Stripe Types Models
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/tax/calculations/object.md

extension Stripe.Tax {
    public struct Calculation: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the calculation.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Total amount after taxes in the smallest currency unit.
        public var amountTotal: Int
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency
        /// The customer's details for the calculation.
        public var customerDetails: CustomerDetails?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// The customer's tax IDs.
        public var customerTaxIds: [CustomerTaxID]?
        /// Time at which the calculation expires.
        public var expiresAt: Date?
        /// The line items that were used to calculate tax.
        public var lineItems: LineItemList?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// The customer's shipping information for the calculation.
        public var shippingCost: ShippingCost?
        /// The amount of tax to be collected on top of the line item prices.
        public var taxAmountExclusive: Int
        /// The amount of tax already included in the line item prices.
        public var taxAmountInclusive: Int
        /// Breakdown of individual tax amounts that contribute to the total.
        public var taxBreakdown: [TaxBreakdown]?
        /// Timestamp of date of the tax calculation.
        public var taxDate: Date

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case amountTotal = "amount_total"
            case currency
            case customerDetails = "customer_details"
            case created
            case customerTaxIds = "customer_tax_ids"
            case expiresAt = "expires_at"
            case lineItems = "line_items"
            case livemode
            case shippingCost = "shipping_cost"
            case taxAmountExclusive = "tax_amount_exclusive"
            case taxAmountInclusive = "tax_amount_inclusive"
            case taxBreakdown = "tax_breakdown"
            case taxDate = "tax_date"
        }

        public init(
            id: ID,
            object: String,
            amountTotal: Int,
            currency: Stripe.Currency,
            customerDetails: CustomerDetails? = nil,
            created: Date,
            customerTaxIds: [CustomerTaxID]? = nil,
            expiresAt: Date? = nil,
            lineItems: LineItemList? = nil,
            livemode: Bool,
            shippingCost: ShippingCost? = nil,
            taxAmountExclusive: Int,
            taxAmountInclusive: Int,
            taxBreakdown: [TaxBreakdown]? = nil,
            taxDate: Date
        ) {
            self.id = id
            self.object = object
            self.amountTotal = amountTotal
            self.currency = currency
            self.customerDetails = customerDetails
            self.created = created
            self.customerTaxIds = customerTaxIds
            self.expiresAt = expiresAt
            self.lineItems = lineItems
            self.livemode = livemode
            self.shippingCost = shippingCost
            self.taxAmountExclusive = taxAmountExclusive
            self.taxAmountInclusive = taxAmountInclusive
            self.taxBreakdown = taxBreakdown
            self.taxDate = taxDate
        }
    }
}

extension Stripe.Tax.Calculation {
    public struct CustomerDetails: Codable, Hashable, Sendable {
        /// The customer's postal address (for example, home or business location).
        public var address: Address?
        /// The type of customer address provided.
        public var addressSource: AddressSource?
        /// The customer's IP address (IPv4 or IPv6).
        public var ipAddress: String?
        /// The customer's tax exemption. One of none, exempt, or reverse.
        public var taxability: Taxability?
        /// The customer's tax IDs.
        public var taxIds: [TaxID]?

        private enum CodingKeys: String, CodingKey {
            case address
            case addressSource = "address_source"
            case ipAddress = "ip_address"
            case taxability
            case taxIds = "tax_ids"
        }

        public init(
            address: Address? = nil,
            addressSource: AddressSource? = nil,
            ipAddress: String? = nil,
            taxability: Taxability? = nil,
            taxIds: [TaxID]? = nil
        ) {
            self.address = address
            self.addressSource = addressSource
            self.ipAddress = ipAddress
            self.taxability = taxability
            self.taxIds = taxIds
        }
    }

    public struct CustomerTaxID: Codable, Hashable, Sendable {
        /// The type of the tax ID.
        public var type: String
        /// The value of the tax ID.
        public var value: String

        public init(type: String, value: String) {
            self.type = type
            self.value = value
        }
    }

    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The line item amount in the smallest currency unit.
        public var amount: Int
        /// The amount of tax calculated for this line item, in the smallest currency unit.
        public var amountTax: Int
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// The product used for this line item.
        public var product: Stripe.Products.Product.ID?
        /// The number of units of the item being purchased.
        public var quantity: Int
        /// A custom identifier for this line item.
        public var reference: String?
        /// Specifies whether the amount includes taxes.
        public var taxBehavior: TaxBehavior?
        /// The tax code for the line item.
        public var taxCode: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case amount
            case amountTax = "amount_tax"
            case livemode
            case product
            case quantity
            case reference
            case taxBehavior = "tax_behavior"
            case taxCode = "tax_code"
        }

        public init(
            id: ID,
            object: String,
            amount: Int,
            amountTax: Int,
            livemode: Bool,
            product: Stripe.Products.Product.ID? = nil,
            quantity: Int,
            reference: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountTax = amountTax
            self.livemode = livemode
            self.product = product
            self.quantity = quantity
            self.reference = reference
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
        }
    }

    public struct LineItemList: Codable, Hashable, Sendable {
        /// String describing the object type returned.
        public var object: String
        /// Details about each object.
        public var data: [LineItem]
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool
        /// The URL where this list can be accessed.
        public var url: String

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore = "has_more"
            case url
        }

        public init(
            object: String,
            data: [LineItem],
            hasMore: Bool,
            url: String
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }

    public struct ShippingCost: Codable, Hashable, Sendable {
        /// The shipping amount in the smallest currency unit.
        public var amount: Int
        /// The amount of tax calculated for shipping, in the smallest currency unit.
        public var amountTax: Int
        /// The tax code for shipping.
        public var taxCode: String?
        /// Specifies whether the amount includes taxes.
        public var taxBehavior: TaxBehavior?

        private enum CodingKeys: String, CodingKey {
            case amount
            case amountTax = "amount_tax"
            case taxCode = "tax_code"
            case taxBehavior = "tax_behavior"
        }

        public init(
            amount: Int,
            amountTax: Int,
            taxCode: String? = nil,
            taxBehavior: TaxBehavior? = nil
        ) {
            self.amount = amount
            self.amountTax = amountTax
            self.taxCode = taxCode
            self.taxBehavior = taxBehavior
        }
    }

    public struct TaxBreakdown: Codable, Hashable, Sendable {
        /// The amount of tax, in the smallest currency unit.
        public var amount: Int
        /// Whether the tax amount is inclusive or exclusive.
        public var inclusive: Bool
        /// The tax jurisdiction details.
        public var jurisdiction: TaxJurisdiction?
        /// Indicates whether the jurisdiction was determined by the origin or destination address.
        public var sourcing: Sourcing?
        /// The type of tax (for example, sales_tax or vat).
        public var taxRateDetails: TaxRateDetails?
        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public var taxabilityReason: TaxabilityReason?

        private enum CodingKeys: String, CodingKey {
            case amount
            case inclusive
            case jurisdiction
            case sourcing
            case taxRateDetails = "tax_rate_details"
            case taxabilityReason = "taxability_reason"
        }

        public init(
            amount: Int,
            inclusive: Bool,
            jurisdiction: TaxJurisdiction? = nil,
            sourcing: Sourcing? = nil,
            taxRateDetails: TaxRateDetails? = nil,
            taxabilityReason: TaxabilityReason? = nil
        ) {
            self.amount = amount
            self.inclusive = inclusive
            self.jurisdiction = jurisdiction
            self.sourcing = sourcing
            self.taxRateDetails = taxRateDetails
            self.taxabilityReason = taxabilityReason
        }
    }

    public struct TaxJurisdiction: Codable, Hashable, Sendable {
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String
        /// A human-readable name for the jurisdiction.
        public var displayName: String
        /// Indicates the level of the jurisdiction.
        public var level: Level?
        /// ISO 3166-2 subdivision code, without country prefix.
        public var state: String?

        private enum CodingKeys: String, CodingKey {
            case country
            case displayName = "display_name"
            case level
            case state
        }

        public init(
            country: String,
            displayName: String,
            level: Level? = nil,
            state: String? = nil
        ) {
            self.country = country
            self.displayName = displayName
            self.level = level
            self.state = state
        }

        public enum Level: String, Codable, Sendable {
            case city
            case country
            case county
            case district
            case state
        }
    }

    public struct TaxRateDetails: Codable, Hashable, Sendable {
        /// The tax rate percentage as a string (for example, "8.5").
        public var percentageDecimal: String
        /// The tax type, such as vat or sales_tax.
        public var taxType: String?

        private enum CodingKeys: String, CodingKey {
            case percentageDecimal = "percentage_decimal"
            case taxType = "tax_type"
        }

        public init(
            percentageDecimal: String,
            taxType: String? = nil
        ) {
            self.percentageDecimal = percentageDecimal
            self.taxType = taxType
        }
    }

    public struct TaxID: Codable, Hashable, Sendable {
        /// The type of the tax ID.
        public var type: String
        /// The value of the tax ID.
        public var value: String

        public init(type: String, value: String) {
            self.type = type
            self.value = value
        }
    }

    public enum AddressSource: String, Codable, Sendable {
        case shipping
        case billing
    }

    public enum Taxability: String, Codable, Sendable {
        case exempt
        case none
        case reverse
    }

    public enum TaxBehavior: String, Codable, Sendable {
        case exclusive
        case inclusive
    }

    public enum Sourcing: String, Codable, Sendable {
        case destination
        case origin
    }

    public enum TaxabilityReason: String, Codable, Sendable {
        case accountExempt = "account_exempt"
        case customerExempt = "customer_exempt"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case portionProductExempt = "portion_product_exempt"
        case portionReducedRated = "portion_reduced_rated"
        case portionStandardRated = "portion_standard_rated"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case reverseCharge = "reverse_charge"
        case standardRated = "standard_rated"
        case taxableBasisReduced = "taxable_basis_reduced"
        case zeroRated = "zero_rated"
    }
}
