import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

// MARK: - Create
extension Stripe.Terminal.Locations {
    public enum Create {}
}

extension Stripe.Terminal.Locations.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var displayName: String
        public var address: AddressParam
        public var configurationOverrides: String?
        public var metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case address
            case configurationOverrides = "configuration_overrides"
            case metadata
        }

        public init(
            displayName: String,
            address: AddressParam,
            configurationOverrides: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.displayName = displayName
            self.address = address
            self.configurationOverrides = configurationOverrides
            self.metadata = metadata
        }
    }

    public struct AddressParam: Codable, Equatable, Sendable {
        public var line1: String
        public var line2: String?
        public var city: String?
        public var state: String?
        public var country: String
        public var postalCode: String?

        private enum CodingKeys: String, CodingKey {
            case line1
            case line2
            case city
            case state
            case country
            case postalCode = "postal_code"
        }

        public init(
            line1: String,
            line2: String? = nil,
            city: String? = nil,
            state: String? = nil,
            country: String,
            postalCode: String? = nil
        ) {
            self.line1 = line1
            self.line2 = line2
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
    }
}

// MARK: - Update
extension Stripe.Terminal.Locations {
    public enum Update {}
}

extension Stripe.Terminal.Locations.Update {
    public struct Request: Codable, Equatable, Sendable {
        public var displayName: String?
        public var address: AddressParam?
        public var configurationOverrides: String?
        public var metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case address
            case configurationOverrides = "configuration_overrides"
            case metadata
        }

        public init(
            displayName: String? = nil,
            address: AddressParam? = nil,
            configurationOverrides: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.displayName = displayName
            self.address = address
            self.configurationOverrides = configurationOverrides
            self.metadata = metadata
        }
    }

    public struct AddressParam: Codable, Equatable, Sendable {
        public var line1: String?
        public var line2: String?
        public var city: String?
        public var state: String?
        public var country: String?
        public var postalCode: String?

        private enum CodingKeys: String, CodingKey {
            case line1
            case line2
            case city
            case state
            case country
            case postalCode = "postal_code"
        }

        public init(
            line1: String? = nil,
            line2: String? = nil,
            city: String? = nil,
            state: String? = nil,
            country: String? = nil,
            postalCode: String? = nil
        ) {
            self.line1 = line1
            self.line2 = line2
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
    }
}

// MARK: - List
extension Stripe.Terminal.Locations {
    public enum List {}
}

extension Stripe.Terminal.Locations.List {
    public struct Request: Codable, Equatable, Sendable {
        public var endingBefore: String?
        public var limit: Int?
        public var startingAfter: String?

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
        public let data: [Stripe.Terminal.Locations.Location]

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
            data: [Stripe.Terminal.Locations.Location]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
