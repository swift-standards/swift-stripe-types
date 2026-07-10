import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Products.ShippingRates {
    // https://docs.stripe.com/api/shipping_rates/create.md
    public enum Create {}
    // https://docs.stripe.com/api/shipping_rates/update.md
    public enum Update {}
    // https://docs.stripe.com/api/shipping_rates/list.md
    public enum List {}
}

extension Stripe.Products.ShippingRates.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let displayName: String
        public let type: Stripe.Products.Shipping.Rate.`Type`
        public let deliveryEstimate: DeliveryEstimate?
        public let fixedAmount: FixedAmount?
        public let metadata: [String: String]?
        public let taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior?
        public let taxCode: String?

        public init(
            displayName: String,
            type: Stripe.Products.Shipping.Rate.`Type` = .fixedAmount,
            deliveryEstimate: DeliveryEstimate? = nil,
            fixedAmount: FixedAmount? = nil,
            metadata: [String: String]? = nil,
            taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior? = nil,
            taxCode: String? = nil
        ) {
            self.displayName = displayName
            self.type = type
            self.deliveryEstimate = deliveryEstimate
            self.fixedAmount = fixedAmount
            self.metadata = metadata
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
        }

        private enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case type
            case deliveryEstimate = "delivery_estimate"
            case fixedAmount = "fixed_amount"
            case metadata
            case taxBehavior = "tax_behavior"
            case taxCode = "tax_code"
        }

        public struct DeliveryEstimate: Codable, Equatable, Sendable {
            public let maximum: MaxMin?
            public let minimum: MaxMin?

            public init(
                maximum: MaxMin? = nil,
                minimum: MaxMin? = nil
            ) {
                self.maximum = maximum
                self.minimum = minimum
            }

            public struct MaxMin: Codable, Equatable, Sendable {
                public let unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit
                public let value: Int

                public init(
                    unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit,
                    value: Int
                ) {
                    self.unit = unit
                    self.value = value
                }
            }
        }

        public struct FixedAmount: Codable, Equatable, Sendable {
            public let amount: Int
            public let currency: Stripe.Currency
            public let currencyOptions: [String: CurrencyOption]?

            public init(
                amount: Int,
                currency: Stripe.Currency,
                currencyOptions: [String: CurrencyOption]? = nil
            ) {
                self.amount = amount
                self.currency = currency
                self.currencyOptions = currencyOptions
            }

            private enum CodingKeys: String, CodingKey {
                case amount
                case currency
                case currencyOptions = "currency_options"
            }

            public struct CurrencyOption: Codable, Equatable, Sendable {
                public let amount: Int
                public let taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior?

                public init(
                    amount: Int,
                    taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior? = nil
                ) {
                    self.amount = amount
                    self.taxBehavior = taxBehavior
                }

                private enum CodingKeys: String, CodingKey {
                    case amount
                    case taxBehavior = "tax_behavior"
                }
            }
        }
    }
}

extension Stripe.Products.ShippingRates.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let fixedAmount: FixedAmount?
        public let metadata: [String: String]?
        public let taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior?

        public init(
            active: Bool? = nil,
            fixedAmount: FixedAmount? = nil,
            metadata: [String: String]? = nil,
            taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior? = nil
        ) {
            self.active = active
            self.fixedAmount = fixedAmount
            self.metadata = metadata
            self.taxBehavior = taxBehavior
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case fixedAmount = "fixed_amount"
            case metadata
            case taxBehavior = "tax_behavior"
        }

        public struct FixedAmount: Codable, Equatable, Sendable {
            public let currencyOptions: [String: CurrencyOption]?

            public init(
                currencyOptions: [String: CurrencyOption]? = nil
            ) {
                self.currencyOptions = currencyOptions
            }

            private enum CodingKeys: String, CodingKey {
                case currencyOptions = "currency_options"
            }

            public struct CurrencyOption: Codable, Equatable, Sendable {
                public let amount: Int?
                public let taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior?

                public init(
                    amount: Int? = nil,
                    taxBehavior: Stripe.Products.Shipping.Rate.Tax.Behavior? = nil
                ) {
                    self.amount = amount
                    self.taxBehavior = taxBehavior
                }

                private enum CodingKeys: String, CodingKey {
                    case amount
                    case taxBehavior = "tax_behavior"
                }
            }
        }
    }
}

extension Stripe.Products.ShippingRates.List {
    public struct Request: Codable, Equatable, Sendable {
        public let active: Bool?
        public let created: Stripe.DateFilter?
        public let currency: Stripe.Currency?
        public let endingBefore: String?
        public let limit: Int?
        public let startingAfter: String?

        public init(
            active: Bool? = nil,
            created: Stripe.DateFilter? = nil,
            currency: Stripe.Currency? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.active = active
            self.created = created
            self.currency = currency
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case created
            case currency
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Products.Shipping.Rate]

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Products.Shipping.Rate]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
