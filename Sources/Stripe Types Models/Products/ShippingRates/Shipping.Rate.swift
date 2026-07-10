//
//  Shipping.Rate.swift
//
//
//  Created by Andrew Edwards on 12/17/21.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/shipping_rates/object.md

extension Stripe.Products {
    public enum Shipping {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Fixed {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Delivery {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Tax {}
}

extension Stripe.Products.Shipping {
    public struct Rate: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// Whether the shipping rate can be used for new purchases. Defaults to `true`.
        public var active: Bool
        /// The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
        public var displayName: String?
        /// Describes a fixed amount to charge for shipping. Must be present if type is fixed_amount.
        public var fixedAmount: Stripe.Products.Shipping.Rate.Fixed.Amount?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The type of calculation to use on the shipping rate. Can only be fixed_amount for now.
        public var type: Stripe.Products.Shipping.Rate.`Type`?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
        public var deliveryEstimate: Stripe.Products.Shipping.Rate.Delivery.Estimate?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified.
        public var taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior?
        /// A tax code ID. The Shipping tax code is `txcd_92010001`.
        @ExpandableOf<Stripe.Tax.Code> public var taxCode: Stripe.Tax.Code.ID?

        public init(
            id: ID,
            active: Bool,
            displayName: String? = nil,
            fixedAmount: Stripe.Products.Shipping.Rate.Fixed.Amount? = nil,
            metadata: [String: String]? = nil,
            type: Stripe.Products.Shipping.Rate.`Type`? = nil,
            object: String,
            created: Date,
            deliveryEstimate: Stripe.Products.Shipping.Rate.Delivery.Estimate? = nil,
            livemode: Bool? = nil,
            taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior? = nil,
            taxCode: Stripe.Tax.Code.ID? = nil
        ) {
            self.id = id
            self.active = active
            self.displayName = displayName
            self.fixedAmount = fixedAmount
            self.metadata = metadata
            self.type = type
            self.object = object
            self.created = created
            self.deliveryEstimate = deliveryEstimate
            self.livemode = livemode
            self.taxBehavior = taxBehavior
            self._taxCode = Expandable(id: taxCode)
        }
    }
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount {
    public typealias Currency = Stripe.Currency
}

extension Stripe.Products.Shipping.Rate.Fixed {
    public struct Amount: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Shipping rates defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your shipping rate in `eur`, fetch the value of the `eur` key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
        public var currencyOptions:
            [Stripe.Currency: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options]?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency
                .Options]? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.currencyOptions = currencyOptions
        }
    }
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount.Currency {
    public struct Options: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var amount: Int?
        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        public var taxBehavior:
            Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options.TaxBehavior?

        public init(
            amount: Int? = nil,
            taxBehavior: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options.TaxBehavior? =
                nil
        ) {
            self.amount = amount
            self.taxBehavior = taxBehavior
        }
    }
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options {
    public enum TaxBehavior: String, Codable, Sendable {
        case inclusive
        case exclusive
        case unspecified
    }
}

extension Stripe.Products.Shipping.Rate {
    public enum `Type`: String, Codable, Sendable {
        case fixedAmount = "fixed_amount"
    }
}

extension Stripe.Products.Shipping.Rate.Delivery {
    public struct Estimate: Codable, Hashable, Sendable {
        /// The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
        public var maximum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin?
        /// The lower bound of the estimated range. If empty, represents no lower bound.
        public var minimum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin?

        public init(
            maximum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin? = nil,
            minimum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin? = nil
        ) {
            self.maximum = maximum
            self.minimum = minimum
        }
    }
}

extension Stripe.Products.Shipping.Rate.Delivery.Estimate {
    public struct MaxMin: Codable, Hashable, Sendable {
        /// A unit of time.
        public var unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit?
        /// Must be greater than 0.
        public var value: Int?

        public init(
            unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit? = nil,
            value: Int? = nil
        ) {
            self.unit = unit
            self.value = value
        }
    }
}

extension Stripe.Products.Shipping.Rate.Delivery.Estimate {
    public enum Unit: String, Codable, Sendable {
        case hour
        case day
        case businessDay = "business_day"
        case week
        case month
    }
}

extension Stripe.Products.Shipping.Rate.Tax {
    public enum Behavior: String, Codable, Sendable {
        case inclusive
        case exclusive
        case unspecified
    }
}

extension Stripe.Products.Shipping.Rate {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Products.Shipping.Rate]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Products.Shipping.Rate]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
