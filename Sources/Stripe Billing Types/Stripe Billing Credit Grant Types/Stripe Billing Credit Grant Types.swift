import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

// MARK: - Create
extension Stripe.Billing.Credit.Grant {
    public enum Create {}
}

extension Stripe.Billing.Credit.Grant.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Amount of the credit grant.
        public let amount: Amount

        /// Configuration specifying what this credit grant applies to.
        public let applicabilityConfig: ApplicabilityConfig

        /// The category of this credit grant.
        public let category: Stripe.Billing.Credit.Grant.Category

        /// ID of the customer to whom the credit grant applies.
        public let customer: String

        /// The time when the credit becomes effective.
        public let effectiveAt: Date?

        /// The time when the credit will expire.
        public let expiresAt: Date?

        /// Set of key-value pairs.
        public let metadata: [String: String]?

        /// A descriptive name shown in dashboard.
        public let name: String?

        /// Priority for determining which credit to use.
        public let priority: Int?

        public struct Amount: Codable, Equatable, Sendable {
            /// The monetary amount.
            public let monetary: Monetary?

            /// The type of this amount.
            public let type: String

            public struct Monetary: Codable, Equatable, Sendable {
                /// Three-letter ISO currency code.
                public let currency: Stripe.Currency

                /// A positive integer.
                public let value: Int
            }
        }

        public struct ApplicabilityConfig: Codable, Equatable, Sendable {
            /// Scope of what this credit grant applies to.
            public let scope: Scope

            public struct Scope: Codable, Equatable, Sendable {
                /// The price type to which credit applies.
                public let priceType: String?

                /// The specific prices to which credit applies.
                public let prices: [Price]?

                public struct Price: Codable, Equatable, Sendable {
                    /// The price ID.
                    public let id: Stripe.Products.Price.ID
                }

                private enum CodingKeys: String, CodingKey {
                    case priceType = "price_type"
                    case prices
                }
            }
        }

        public init(
            amount: Amount,
            applicabilityConfig: ApplicabilityConfig,
            category: Stripe.Billing.Credit.Grant.Category,
            customer: String,
            effectiveAt: Date? = nil,
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            priority: Int? = nil
        ) {
            self.amount = amount
            self.applicabilityConfig = applicabilityConfig
            self.category = category
            self.customer = customer
            self.effectiveAt = effectiveAt
            self.expiresAt = expiresAt
            self.metadata = metadata
            self.name = name
            self.priority = priority
        }

        private enum CodingKeys: String, CodingKey {
            case amount
            case applicabilityConfig = "applicability_config"
            case category
            case customer
            case effectiveAt = "effective_at"
            case expiresAt = "expires_at"
            case metadata
            case name
            case priority
        }
    }
}

// MARK: - Update
extension Stripe.Billing.Credit.Grant {
    public enum Update {}
}

extension Stripe.Billing.Credit.Grant.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The time when the credit will expire.
        public let expiresAt: Date?

        /// Set of key-value pairs.
        public let metadata: [String: String]?

        public init(
            expiresAt: Date? = nil,
            metadata: [String: String]? = nil
        ) {
            self.expiresAt = expiresAt
            self.metadata = metadata
        }

        private enum CodingKeys: String, CodingKey {
            case expiresAt = "expires_at"
            case metadata
        }
    }
}

// MARK: - List
extension Stripe.Billing.Credit.Grant {
    public enum List {}
}

extension Stripe.Billing.Credit.Grant.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return credit grants for this customer.
        public let customer: Stripe.Customers.Customer.ID?

        /// A cursor for use in pagination.
        public let endingBefore: String?

        /// A cursor for use in pagination.
        public let startingAfter: String?

        /// A limit on the number of objects to be returned.
        public let limit: Int?

        public init(
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            startingAfter: String? = nil,
            limit: Int? = nil
        ) {
            self.customer = customer
            self.endingBefore = endingBefore
            self.startingAfter = startingAfter
            self.limit = limit
        }

        private enum CodingKeys: String, CodingKey {
            case customer
            case endingBefore = "ending_before"
            case startingAfter = "starting_after"
            case limit
        }
    }

    public struct Response: Codable, Sendable {
        /// String representing the object's type.
        public let object: String

        /// The URL where this list can be accessed.
        public let url: String

        /// True if this list has another page of items after this one.
        public let hasMore: Bool

        /// An array of credit grants.
        public let data: [Stripe.Billing.Credit.Grant]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}

// MARK: - Expire
extension Stripe.Billing.Credit.Grant {
    public enum Expire {}
}

extension Stripe.Billing.Credit.Grant.Expire {
    public struct Request: Codable, Equatable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public let expand: [String]?

        public init(expand: [String]? = nil) {
            self.expand = expand
        }
    }
}

// MARK: - Void
extension Stripe.Billing.Credit.Grant {
    public enum Void {}
}

extension Stripe.Billing.Credit.Grant.Void {
    public struct Request: Codable, Equatable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public let expand: [String]?

        public init(expand: [String]? = nil) {
            self.expand = expand
        }
    }
}
