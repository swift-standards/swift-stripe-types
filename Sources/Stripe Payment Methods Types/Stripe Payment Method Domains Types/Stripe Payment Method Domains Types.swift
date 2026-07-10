import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.PaymentMethodDomains {
    // https://docs.stripe.com/api/payment_method_domains/create.md
    public enum Create {}
    // https://docs.stripe.com/api/payment_method_domains/update.md
    public enum Update {}
    // https://docs.stripe.com/api/payment_method_domains/list.md
    public enum List {}
}

extension Stripe.PaymentMethodDomains.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The domain name that this payment method domain object represents.
        public let domainName: String
        /// Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements or Embedded Checkout.
        public let enabled: Bool?

        private enum CodingKeys: String, CodingKey {
            case domainName = "domain_name"
            case enabled
        }

        public init(
            domainName: String,
            enabled: Bool? = nil
        ) {
            self.domainName = domainName
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentMethodDomains.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements or Embedded Checkout.
        public let enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

extension Stripe.PaymentMethodDomains.List {
    public struct Request: Codable, Equatable, Sendable {
        /// The domain name that this payment method domain object represents.
        public let domainName: String?
        /// Whether this payment method domain is enabled.
        public let enabled: Bool?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_bar, your subsequent call can include ending_before=obj_bar in order to fetch the previous page of the list.
        public let endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case domainName = "domain_name"
            case enabled
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }

        public init(
            domainName: String? = nil,
            enabled: Bool? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.domainName = domainName
            self.enabled = enabled
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.PaymentMethodDomain]

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.PaymentMethodDomain]
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
