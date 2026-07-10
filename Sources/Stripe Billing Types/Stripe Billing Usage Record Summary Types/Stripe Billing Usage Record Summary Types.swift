import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Billing.UsageRecordSummary {
    public struct Summary: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        public let id: ID
        public let object: String
        public let invoice: Stripe.Billing.Invoice.ID?
        public let livemode: Bool
        public let period: Period
        public let subscriptionItem: String
        public let totalUsage: Int

        public struct Period: Codable, Equatable, Sendable {
            public let start: Int
            public let end: Int?
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case invoice
            case livemode
            case period
            case subscriptionItem = "subscription_item"
            case totalUsage = "total_usage"
        }
    }
}

// MARK: - List
extension Stripe.Billing.UsageRecordSummary {
    public enum List {}
}

extension Stripe.Billing.UsageRecordSummary.List {
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
        public let data: [Stripe.Billing.UsageRecordSummary.Summary]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
