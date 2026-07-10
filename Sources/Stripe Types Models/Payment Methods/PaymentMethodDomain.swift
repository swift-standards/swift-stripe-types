//
//  PaymentMethodDomain.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 14/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/payment_method_domains/object.md

extension Stripe {
    public struct PaymentMethodDomain: Codable, Hashable, Sendable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Amazon Pay's eligibility status on this domain.
        public var amazonPay: PaymentMethodStatus?
        /// Apple Pay's eligibility status on this domain.
        public var applePay: PaymentMethodStatus?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// The domain name that this payment method domain object represents.
        public var domainName: String
        /// Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements or Embedded Checkout.
        public var enabled: Bool
        /// Google Pay's eligibility status on this domain.
        public var googlePay: PaymentMethodStatus?
        /// Klarna's eligibility status on this domain.
        public var klarna: PaymentMethodStatus?
        /// Link's eligibility status on this domain.
        public var link: PaymentMethodStatus?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// PayPal's eligibility status on this domain.
        public var paypal: PaymentMethodStatus?

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case amazonPay = "amazon_pay"
            case applePay = "apple_pay"
            case created
            case domainName = "domain_name"
            case enabled
            case googlePay = "google_pay"
            case klarna
            case link
            case livemode
            case paypal
        }

        public init(
            id: ID,
            object: String,
            amazonPay: PaymentMethodStatus? = nil,
            applePay: PaymentMethodStatus? = nil,
            created: Date,
            domainName: String,
            enabled: Bool,
            googlePay: PaymentMethodStatus? = nil,
            klarna: PaymentMethodStatus? = nil,
            link: PaymentMethodStatus? = nil,
            livemode: Bool? = nil,
            paypal: PaymentMethodStatus? = nil
        ) {
            self.id = id
            self.object = object
            self.amazonPay = amazonPay
            self.applePay = applePay
            self.created = created
            self.domainName = domainName
            self.enabled = enabled
            self.googlePay = googlePay
            self.klarna = klarna
            self.link = link
            self.livemode = livemode
            self.paypal = paypal
        }

        public struct PaymentMethodStatus: Codable, Hashable, Sendable {
            /// The status of the payment method domain on this domain.
            public var status: Status?
            /// Additional status details.
            public var statusDetails: StatusDetails?

            private enum CodingKeys: String, CodingKey {
                case status
                case statusDetails = "status_details"
            }

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            public enum Status: String, Codable, Sendable {
                case active
                case inactive
            }

            public struct StatusDetails: Codable, Hashable, Sendable {
                // Details would be specified here when available
                public init() {}
            }
        }
    }
}
