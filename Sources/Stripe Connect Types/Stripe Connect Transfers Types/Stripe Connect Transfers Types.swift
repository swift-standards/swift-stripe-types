import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Connect.Transfers {
    // https://docs.stripe.com/api/transfers/create.md
    public enum Create {}

    // https://docs.stripe.com/api/transfers/update.md
    public enum Update {}

    // https://docs.stripe.com/api/transfers/list.md
    public enum List {}
}

extension Stripe.Connect.Transfers.Create {
    public struct Request: Codable, Equatable, Sendable {
        public let amount: Int
        public let currency: Stripe.Currency
        public let destination: Stripe.Connect.Account.ID
        public let description: String?
        public let metadata: [String: String]?
        public let sourceTransaction: String?
        public let sourceType: Stripe.Connect.Transfer.SourceType?
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case destination
            case description
            case metadata
            case sourceTransaction = "source_transaction"
            case sourceType = "source_type"
            case transferGroup = "transfer_group"
        }

        public init(
            amount: Int,
            currency: Stripe.Currency,
            destination: Stripe.Connect.Account.ID,
            description: String? = nil,
            metadata: [String: String]? = nil,
            sourceTransaction: String? = nil,
            sourceType: Stripe.Connect.Transfer.SourceType? = nil,
            transferGroup: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.destination = destination
            self.description = description
            self.metadata = metadata
            self.sourceTransaction = sourceTransaction
            self.sourceType = sourceType
            self.transferGroup = transferGroup
        }
    }
}

extension Stripe.Connect.Transfers.Update {
    public struct Request: Codable, Equatable, Sendable {
        public let description: String?
        public let metadata: [String: String]?

        public init(
            description: String? = nil,
            metadata: [String: String]? = nil
        ) {
            self.description = description
            self.metadata = metadata
        }
    }
}

extension Stripe.Connect.Transfers.List {
    public struct Request: Codable, Equatable, Sendable {
        public let created: Stripe.DateFilter?
        public let destination: Stripe.Connect.Account.ID?
        public let endingBefore: String?
        public let limit: Int?
        public let startingAfter: String?
        public let transferGroup: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case destination
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
            case transferGroup = "transfer_group"
        }

        public init(
            created: Stripe.DateFilter? = nil,
            destination: Stripe.Connect.Account.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            transferGroup: String? = nil
        ) {
            self.created = created
            self.destination = destination
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.transferGroup = transferGroup
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Connect.Transfer]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
