import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers {
    public enum Cards: Sendable {}
}

extension Stripe.Customers.Cards {
    // https://docs.stripe.com/api/cards/create.md
    public enum Create {}
    // https://docs.stripe.com/api/cards/update.md
    public enum Update {}
    // https://docs.stripe.com/api/cards/list.md
    public enum List {}
}

extension Stripe.Customers.Cards.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// A token, like the ones returned by Stripe.js, or a card dictionary.
        public let source: Source
        /// Set of key-value pairs that you can attach to an object.
        public let metadata: [String: String]?

        public init(
            source: Source,
            metadata: [String: String]? = nil
        ) {
            self.source = source
            self.metadata = metadata
        }

        public enum Source: Codable, Equatable, Sendable {
            case token(String)
            case card(CardDetails)

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .token(let token):
                    try container.encode(token)
                case .card(let details):
                    try container.encode(details)
                }
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                if let token = try? container.decode(String.self) {
                    self = .token(token)
                } else {
                    let details = try container.decode(CardDetails.self)
                    self = .card(details)
                }
            }
        }

        public struct CardDetails: Codable, Equatable, Sendable {
            /// The card number, as a string without any separators.
            public let number: String
            /// Two-digit number representing the card's expiration month.
            public let expMonth: Int
            /// Two- or four-digit number representing the card's expiration year.
            public let expYear: Int
            /// Card security code.
            public let cvc: String?
            /// Cardholder's full name.
            public let name: String?
            /// Address line 1 (Street address/PO Box/Company name).
            public let addressLine1: String?
            /// Address line 2 (Apartment/Suite/Unit/Building).
            public let addressLine2: String?
            /// City/District/Suburb/Town/Village.
            public let addressCity: String?
            /// State/County/Province/Region.
            public let addressState: String?
            /// ZIP or postal code.
            public let addressZip: String?
            /// Two-letter country code (ISO 3166-1 alpha-2).
            public let addressCountry: String?

            private enum CodingKeys: String, CodingKey {
                case number
                case expMonth = "exp_month"
                case expYear = "exp_year"
                case cvc
                case name
                case addressLine1 = "address_line1"
                case addressLine2 = "address_line2"
                case addressCity = "address_city"
                case addressState = "address_state"
                case addressZip = "address_zip"
                case addressCountry = "address_country"
                case object
            }

            public init(
                number: String,
                expMonth: Int,
                expYear: Int,
                cvc: String? = nil,
                name: String? = nil,
                addressLine1: String? = nil,
                addressLine2: String? = nil,
                addressCity: String? = nil,
                addressState: String? = nil,
                addressZip: String? = nil,
                addressCountry: String? = nil
            ) {
                self.number = number
                self.expMonth = expMonth
                self.expYear = expYear
                self.cvc = cvc
                self.name = name
                self.addressLine1 = addressLine1
                self.addressLine2 = addressLine2
                self.addressCity = addressCity
                self.addressState = addressState
                self.addressZip = addressZip
                self.addressCountry = addressCountry
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode("card", forKey: .object)
                try container.encode(number, forKey: .number)
                try container.encode(expMonth, forKey: .expMonth)
                try container.encode(expYear, forKey: .expYear)
                try container.encodeIfPresent(cvc, forKey: .cvc)
                try container.encodeIfPresent(name, forKey: .name)
                try container.encodeIfPresent(addressLine1, forKey: .addressLine1)
                try container.encodeIfPresent(addressLine2, forKey: .addressLine2)
                try container.encodeIfPresent(addressCity, forKey: .addressCity)
                try container.encodeIfPresent(addressState, forKey: .addressState)
                try container.encodeIfPresent(addressZip, forKey: .addressZip)
                try container.encodeIfPresent(addressCountry, forKey: .addressCountry)
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.number = try container.decode(String.self, forKey: .number)
                self.expMonth = try container.decode(Int.self, forKey: .expMonth)
                self.expYear = try container.decode(Int.self, forKey: .expYear)
                self.cvc = try container.decodeIfPresent(String.self, forKey: .cvc)
                self.name = try container.decodeIfPresent(String.self, forKey: .name)
                self.addressLine1 = try container.decodeIfPresent(
                    String.self,
                    forKey: .addressLine1
                )
                self.addressLine2 = try container.decodeIfPresent(
                    String.self,
                    forKey: .addressLine2
                )
                self.addressCity = try container.decodeIfPresent(String.self, forKey: .addressCity)
                self.addressState = try container.decodeIfPresent(
                    String.self,
                    forKey: .addressState
                )
                self.addressZip = try container.decodeIfPresent(String.self, forKey: .addressZip)
                self.addressCountry = try container.decodeIfPresent(
                    String.self,
                    forKey: .addressCountry
                )
            }
        }
    }
}

extension Stripe.Customers.Cards.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Cardholder's full name.
        public let name: String?
        /// Address line 1.
        public let addressLine1: String?
        /// Address line 2.
        public let addressLine2: String?
        /// City/District/Suburb/Town/Village.
        public let addressCity: String?
        /// State/County/Province/Region.
        public let addressState: String?
        /// ZIP or postal code.
        public let addressZip: String?
        /// Two-letter country code.
        public let addressCountry: String?
        /// Two-digit number representing the card's expiration month.
        public let expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public let expYear: Int?
        /// Set of key-value pairs that you can attach to an object.
        public let metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case name
            case addressLine1 = "address_line1"
            case addressLine2 = "address_line2"
            case addressCity = "address_city"
            case addressState = "address_state"
            case addressZip = "address_zip"
            case addressCountry = "address_country"
            case expMonth = "exp_month"
            case expYear = "exp_year"
            case metadata
        }

        public init(
            name: String? = nil,
            addressLine1: String? = nil,
            addressLine2: String? = nil,
            addressCity: String? = nil,
            addressState: String? = nil,
            addressZip: String? = nil,
            addressCountry: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            metadata: [String: String]? = nil
        ) {
            self.name = name
            self.addressLine1 = addressLine1
            self.addressLine2 = addressLine2
            self.addressCity = addressCity
            self.addressState = addressState
            self.addressZip = addressZip
            self.addressCountry = addressCountry
            self.expMonth = expMonth
            self.expYear = expYear
            self.metadata = metadata
        }
    }
}

extension Stripe.Customers.Cards.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned.
        public let limit: Int?
        /// A cursor for use in pagination.
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Card]

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Card]
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
