import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Fraud.EarlyFraudWarnings.API {
    // https://docs.stripe.com/api/radar/early_fraud_warnings/list.md
    public enum List {}
}

extension Stripe.Fraud.EarlyFraudWarnings.API.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return early fraud warnings for the charge specified by this charge ID.
        public var charge: Stripe.Charges.Charge.ID?
        /// Only return early fraud warnings for charges that were created by the PaymentIntent specified by this PaymentIntent ID.
        public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case charge
            case paymentIntent = "payment_intent"
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }

        public init(
            charge: Stripe.Charges.Charge.ID? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.charge = charge
            self.paymentIntent = paymentIntent
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }
}

extension Stripe.Fraud.EarlyFraudWarnings.API.List {
    public struct Response: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning]?
        public var hasMore: Bool?
        public var url: String?

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore = "has_more"
            case url
        }

        public init(
            object: String,
            data: [Stripe.Fraud.EarlyFraudWarnings.EarlyFraudWarning]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
