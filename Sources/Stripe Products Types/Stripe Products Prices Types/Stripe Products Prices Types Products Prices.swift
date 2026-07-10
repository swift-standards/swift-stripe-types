//
//  File.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 07/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Products.Prices {
    public enum Create {}
    public enum Update {}
    public enum List {}
    public enum Search {}
}

extension Stripe.Products.Prices.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let currency: Stripe.Currency
        public let active: Bool?
        public let metadata: [String: String]?
        public let nickname: String?
        public let product: Stripe.Products.Product.ID?
        public let recurring: Stripe.Products.Price.Recurring?
        public let taxBehavior: Stripe.Products.Price.TaxBehavior?
        public let unitAmount: Int?
        public let billingScheme: Stripe.Products.Price.Billing.Scheme?
        public let currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]?
        public let customUnitAmount: Stripe.Products.Price.CustomUnitAmount?
        public let lookupKey: String?
        public let productData: ProductData?
        public let tiers: [Stripe.Products.Price.Tier]?
        public let tiersMode: Stripe.Products.Price.TierMode?
        public let transferLookupKey: Bool?
        public let transformQuantity: Stripe.Products.Price.TransformQuantity?
        public let unitAmountDecimal: String?

        private enum CodingKeys: String, CodingKey {
            case currency
            case active
            case metadata
            case nickname
            case product
            case recurring
            case taxBehavior = "tax_behavior"
            case unitAmount = "unit_amount"
            case billingScheme = "billing_scheme"
            case currencyOptions = "currency_options"
            case customUnitAmount = "custom_unit_amount"
            case lookupKey = "lookup_key"
            case productData = "product_data"
            case tiers
            case tiersMode = "tiers_mode"
            case transferLookupKey = "transfer_lookup_key"
            case transformQuantity = "transform_quantity"
            case unitAmountDecimal = "unit_amount_decimal"
        }

        public init(
            currency: Stripe.Currency,
            active: Bool? = nil,
            metadata: [String: String]? = nil,
            nickname: String? = nil,
            product: Stripe.Products.Product.ID? = nil,
            recurring: Stripe.Products.Price.Recurring? = nil,
            taxBehavior: Stripe.Products.Price.TaxBehavior? = nil,
            unitAmount: Int? = nil,
            billingScheme: Stripe.Products.Price.Billing.Scheme? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]? = nil,
            customUnitAmount: Stripe.Products.Price.CustomUnitAmount? = nil,
            lookupKey: String? = nil,
            productData: ProductData? = nil,
            tiers: [Stripe.Products.Price.Tier]? = nil,
            tiersMode: Stripe.Products.Price.TierMode? = nil,
            transferLookupKey: Bool? = nil,
            transformQuantity: Stripe.Products.Price.TransformQuantity? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.currency = currency
            self.active = active
            self.metadata = metadata
            self.nickname = nickname
            self.product = product
            self.recurring = recurring
            self.taxBehavior = taxBehavior
            self.unitAmount = unitAmount
            self.billingScheme = billingScheme
            self.currencyOptions = currencyOptions
            self.customUnitAmount = customUnitAmount
            self.lookupKey = lookupKey
            self.productData = productData
            self.tiers = tiers
            self.tiersMode = tiersMode
            self.transferLookupKey = transferLookupKey
            self.transformQuantity = transformQuantity
            self.unitAmountDecimal = unitAmountDecimal
        }
    }

    public struct ProductData: Codable, Equatable, Sendable {
        public let name: String
        public let active: Bool?
        public let id: String?
        public let metadata: [String: String]?
        public let statementDescriptor: Stripe.StatementDescriptor?
        public let taxCode: String?
        public let unitLabel: String?

        private enum CodingKeys: String, CodingKey {
            case name
            case active
            case id
            case metadata
            case statementDescriptor = "statement_descriptor"
            case taxCode = "tax_code"
            case unitLabel = "unit_label"
        }

        public init(
            name: String,
            active: Bool? = nil,
            id: String? = nil,
            metadata: [String: String]? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            taxCode: String? = nil,
            unitLabel: String? = nil
        ) {
            self.name = name
            self.active = active
            self.id = id
            self.metadata = metadata
            self.statementDescriptor = statementDescriptor
            self.taxCode = taxCode
            self.unitLabel = unitLabel
        }
    }
}

extension Stripe.Products.Prices.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let metadata: [String: String]?
        public let nickname: String?
        public let currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]?
        public let lookupKey: String?
        public let taxBehavior: Stripe.Products.Price.TaxBehavior?
        public let transferLookupKey: Bool?

        private enum CodingKeys: String, CodingKey {
            case active
            case metadata
            case nickname
            case currencyOptions = "currency_options"
            case lookupKey = "lookup_key"
            case taxBehavior = "tax_behavior"
            case transferLookupKey = "transfer_lookup_key"
        }

        public init(
            active: Bool? = nil,
            metadata: [String: String]? = nil,
            nickname: String? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Price.Currency.Option]? = nil,
            lookupKey: String? = nil,
            taxBehavior: Stripe.Products.Price.TaxBehavior? = nil,
            transferLookupKey: Bool? = nil
        ) {
            self.active = active
            self.metadata = metadata
            self.nickname = nickname
            self.currencyOptions = currencyOptions
            self.lookupKey = lookupKey
            self.taxBehavior = taxBehavior
            self.transferLookupKey = transferLookupKey
        }
    }
}

extension Stripe.Products.Prices.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return prices that are active or inactive
        public let active: Bool?
        /// Only return prices for the given currency
        public let currency: Stripe.Currency?
        /// Only return prices that were created during the given date interval
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned (1-100, default 10)
        public let limit: Int?
        /// Only return prices with these lookup keys
        public let lookupKeys: [String]?
        /// Only return prices for the given product
        public let product: Stripe.Products.Product.ID?
        /// Filter prices by recurring properties
        public let recurring: String?  // Price.Recurring.Filter serialized
        /// A cursor for use in pagination
        public let startingAfter: String?
        /// Only return prices of the given type
        public let type: String?

        private enum CodingKeys: String, CodingKey {
            case active
            case currency
            case created
            case endingBefore = "ending_before"
            case limit
            case lookupKeys = "lookup_keys"
            case product
            case recurring
            case startingAfter = "starting_after"
            case type
        }

        public init(
            active: Bool? = nil,
            currency: Stripe.Currency? = nil,
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            lookupKeys: [String]? = nil,
            product: Stripe.Products.Product.ID? = nil,
            recurring: String? = nil,  // Price.Recurring.Filter serialized
            startingAfter: String? = nil,
            type: String? = nil
        ) {
            self.active = active
            self.currency = currency
            self.created = created
            self.endingBefore = endingBefore
            self.limit = limit
            self.lookupKeys = lookupKeys
            self.product = product
            self.recurring = recurring
            self.startingAfter = startingAfter
            self.type = type
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Products.Price]

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
            data: [Stripe.Products.Price]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// Add Price.Recurring.Filter type
extension Stripe.Products.Price.Recurring {
    public struct Filter: Codable, Equatable, Sendable {
        public let interval: String?
        public let usageType: String?

        private enum CodingKeys: String, CodingKey {
            case interval
            case usageType = "usage_type"
        }

        public init(
            interval: String? = nil,
            usageType: String? = nil
        ) {
            self.interval = interval
            self.usageType = usageType
        }
    }
}

extension Stripe.Products.Prices.Search {
    public struct Request: Codable, Equatable, Sendable {
        public let query: String
        public let limit: Int?
        public let page: String?

        public init(
            query: String,
            limit: Int? = nil,
            page: String? = nil
        ) {
            self.query = query
            self.limit = limit
            self.page = page
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Products.Price]
        public let nextPage: String?
        public let totalCount: Int?

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
            case nextPage = "next_page"
            case totalCount = "total_count"
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Products.Price],
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
