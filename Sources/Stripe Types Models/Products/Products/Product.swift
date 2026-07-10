//
//  Product.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/products/object.md

/// The [Product Object](https://stripe.com/docs/api/products/object) .
extension Stripe.Products {
    public struct Product: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// Whether the product is currently available for purchase.
        public var active: Bool?
        /// The ID of the Price object that is the default price for this product.
        @ExpandableOf<Stripe.Products.Price> public var defaultPrice
        /// The product’s description, meant to be displayable to the customer. Only applicable to products of `type=good`.
        public var description: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The product’s name, meant to be displayable to the customer.
        public var name: String?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// A list of up to 8 URLs of images for this product, meant to be displayable to the customer. Only applicable to products of `type=good`.
        public var images: [String]?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// The dimensions of this product for shipping purposes.
        public var packageDimensions: Package.Dimensions?
        /// Whether this product is shipped (i.e., physical goods).
        public var shippable: Bool?
        /// Extra information about a product which will appear on your customer’s credit card statement. In the case that multiple products are billed at once, the first statement descriptor will be used.
        public var statementDescriptor: Stripe.StatementDescriptor?
        /// A tax code ID.
        @ExpandableOf<Stripe.Tax.Code> public var taxCode
        /// A label that represents units of this product. When set, this will be included in customers’ receipts, invoices, Checkout, and the customer portal.
        public var unitLabel: String?
        /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
        public var updated: Date?
        /// A URL of a publicly-accessible webpage for this product.
        public var url: String?
        /// The marketing feature name. Up to 80 characters long.
        public var marketingFeatures: [Marketing.Feature]?
        /// A list of attributes for this product.
        public var attributes: [String]?
        /// The type of the product. The product is either of type `good`, which is eligible for use with Orders and SKUs, or `service`, which is eligible for use with Subscriptions and Plans.
        public var type: Product.ProductType?

        private enum CodingKeys: String, CodingKey {
            case id
            case active
            case defaultPrice = "default_price"
            case description
            case metadata
            case name
            case object
            case created
            case images
            case livemode
            case packageDimensions = "package_dimensions"
            case shippable
            case statementDescriptor = "statement_descriptor"
            case taxCode = "tax_code"
            case unitLabel = "unit_label"
            case updated
            case url
            case marketingFeatures = "marketing_features"
            case attributes
            case type
        }

        public init(
            id: ID,
            active: Bool? = nil,
            defaultPrice: Stripe.Products.Price.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            object: String,
            created: Date,
            images: [String]? = nil,
            livemode: Bool? = nil,
            packageDimensions: Package.Dimensions? = nil,
            shippable: Bool? = nil,
            statementDescriptor: Stripe.StatementDescriptor? = nil,
            taxCode: Stripe.Tax.Code.ID? = nil,
            unitLabel: String? = nil,
            updated: Date? = nil,
            url: String? = nil,
            marketingFeatures: [Marketing.Feature]? = nil,
            attributes: [String]? = nil,
            type: Product.ProductType? = nil
        ) {
            self.id = id
            self.active = active
            self._defaultPrice = Expandable(id: defaultPrice)
            self.description = description
            self.metadata = metadata
            self.name = name
            self.object = object
            self.created = created
            self.images = images
            self.livemode = livemode
            self.packageDimensions = packageDimensions
            self.shippable = shippable
            self.statementDescriptor = statementDescriptor
            self._taxCode = Expandable(id: taxCode)
            self.unitLabel = unitLabel
            self.updated = updated
            self.url = url
            self.marketingFeatures = marketingFeatures
            self.attributes = attributes
            self.type = type
        }
    }
}

extension Stripe.Products.Product {
    public enum Package {}

    /// The type of the product.
    public enum ProductType: String, Codable, Hashable, Sendable {
        /// A service product.
        case service = "service"
        /// A physical good product.
        case good = "good"
    }
}

public enum Marketing {}

extension Marketing {
    public struct Feature: Codable, Hashable, Sendable {
        public var name: String?

        public init(
            name: String? = nil
        ) {
            self.name = name
        }
    }
}

extension Stripe.Products.Product.Package {
    public struct Dimensions: Codable, Hashable, Sendable {
        /// Height, in inches.
        public var height: Decimal?
        /// Length, in inches.
        public var length: Decimal?
        /// Weight, in inches.
        public var weight: Decimal?
        /// Width, in inches.
        public var width: Decimal?

        public init(
            height: Decimal? = nil,
            length: Decimal? = nil,
            weight: Decimal? = nil,
            width: Decimal? = nil
        ) {
            self.height = height
            self.length = length
            self.weight = weight
            self.width = width
        }
    }
}

extension Stripe.Products.Product {
    public enum Search {}
}

extension Stripe.Products.Product.Search {
    public struct Result: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of products, paginated by any request parameters.
        public var data: [Stripe.Products.Product]?
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
            data: [Stripe.Products.Product]? = nil,
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

extension Stripe.Products.Product {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Products.Product]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Products.Product]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
