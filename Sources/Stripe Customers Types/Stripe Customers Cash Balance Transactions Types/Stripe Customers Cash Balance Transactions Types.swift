import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers {
    public enum CashBalanceTransactions: Sendable {}
}

extension Stripe.Customers.CashBalanceTransactions {
    // https://docs.stripe.com/api/cash_balance_transactions/list.md
    public enum List {}
}

extension Stripe.Customers.CashBalanceTransactions.List {
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
        public let data: [CashBalanceTransaction]

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [CashBalanceTransaction]
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
