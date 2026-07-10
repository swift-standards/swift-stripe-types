import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Capital {
    public struct FinancingOffer: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        public let id: ID
        public let object: String
        public let account: String
        public let created: Date
        public let expiresAfter: Date
        public let financingType: String
        public let livemode: Bool
        public let offeredTerms: OfferedTerms
        public let productType: String
        public let status: Status

        public struct OfferedTerms: Codable, Equatable, Sendable {
            public let advanceAmount: Int
            public let campaignType: String
            public let currency: Stripe.Currency
            public let feeAmount: Int
            public let previousFinancingFeeDiscountRate: Double?
            public let withholdRate: Double

            private enum CodingKeys: String, CodingKey {
                case advanceAmount = "advance_amount"
                case campaignType = "campaign_type"
                case currency
                case feeAmount = "fee_amount"
                case previousFinancingFeeDiscountRate = "previous_financing_fee_discount_rate"
                case withholdRate = "withhold_rate"
            }
        }

        public enum Status: String, Codable, Equatable, Sendable {
            case undelivered
            case delivered
            case accepted
            case declined
            case canceled
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case account
            case created
            case expiresAfter = "expires_after"
            case financingType = "financing_type"
            case livemode
            case offeredTerms = "offered_terms"
            case productType = "product_type"
            case status
        }
    }
}
