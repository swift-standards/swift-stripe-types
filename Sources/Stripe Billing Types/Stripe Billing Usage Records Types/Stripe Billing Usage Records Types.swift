import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

// Helper type for timestamp that can be either an integer or "now"
public enum Either<A: Codable & Equatable & Sendable, B: Codable & Equatable & Sendable>: Codable,
    Equatable, Sendable
{
    case left(A)
    case right(B)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let a = try? container.decode(A.self) {
            self = .left(a)
        } else if let b = try? container.decode(B.self) {
            self = .right(b)
        } else {
            throw DecodingError.typeMismatch(
                Either.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Could not decode Either"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .left(let a):
            try container.encode(a)
        case .right(let b):
            try container.encode(b)
        }
    }
}

extension Stripe.Billing.UsageRecords {
    public struct UsageRecord: Codable, Equatable, Sendable, Identifiable {
        public let id: ID
        public let object: String
        public let livemode: Bool
        public let quantity: Int
        public let subscriptionItem: String
        public let timestamp: Int

        public typealias ID = Tagged<Self, String>

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case livemode
            case quantity
            case subscriptionItem = "subscription_item"
            case timestamp
        }
    }
}

// MARK: - Create
extension Stripe.Billing.UsageRecords {
    public enum Create {}
}

extension Stripe.Billing.UsageRecords.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The usage quantity for the specified timestamp.
        public let quantity: Int

        /// The timestamp for the usage event. This timestamp must be within the current billing period of the subscription of the provided subscription_item.
        public let timestamp: Either<Int, Keyword>

        /// Valid values are increment (default) or set. When using increment the specified quantity will be added to the usage at the specified timestamp. The set action will overwrite the usage quantity at that timestamp. If the subscription has billing thresholds, increment is the only allowed value.
        public let action: Action?

        public enum Keyword: String, Codable, Equatable, Sendable {
            case now
        }

        public enum Action: String, Codable, Equatable, Sendable {
            case increment
            case set
        }

        public init(
            quantity: Int,
            timestamp: Either<Int, Keyword> = .right(.now),
            action: Action? = nil
        ) {
            self.quantity = quantity
            self.timestamp = timestamp
            self.action = action
        }
    }
}

// MARK: - List
extension Stripe.Billing.UsageRecords {
    public enum List {}
}

extension Stripe.Billing.UsageRecords.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?

        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?

        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.UsageRecords.UsageRecord]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
