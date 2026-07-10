//
//  ConfirmationToken.swift
//  Stripe Types
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/confirmation_tokens/object.md

/// The [Confirmation Token Object](https://docs.stripe.com/api/confirmation_tokens/object).
public struct ConfirmationToken: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = Tagged<Self, String>

    /// Unique identifier for the object.
    public var id: ID
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Time at which the object expires. Measured in seconds since the Unix epoch.
    public var expiresAt: Date?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Data to generate a Mandate.
    public var mandateData: MandateData?
    /// ID of the PaymentIntent that this ConfirmationToken will confirm.
    public var paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
    /// Payment method preview for this ConfirmationToken.
    public var paymentMethodPreview: PaymentMethodPreview?
    /// Return URL used to confirm the Intent.
    public var returnUrl: String?
    /// Indicates that you intend to make future payments with this ConfirmationToken's payment method.
    public var setupFutureUsage: SetupFutureUsage?
    /// ID of the SetupIntent that this ConfirmationToken will confirm.
    public var setupIntent: Stripe.Setup.Intent.ID?
    /// Shipping information for this ConfirmationToken.
    public var shipping: Shipping?
    /// Indicates whether the Stripe SDK is used for confirmation flow.
    public var useStripeSdk: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case expiresAt = "expires_at"
        case livemode
        case mandateData = "mandate_data"
        case paymentIntent = "payment_intent"
        case paymentMethodPreview = "payment_method_preview"
        case returnUrl = "return_url"
        case setupFutureUsage = "setup_future_usage"
        case setupIntent = "setup_intent"
        case shipping
        case useStripeSdk = "use_stripe_sdk"
    }

    public init(
        id: ID,
        object: String,
        created: Date,
        expiresAt: Date? = nil,
        livemode: Bool? = nil,
        mandateData: MandateData? = nil,
        paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
        paymentMethodPreview: PaymentMethodPreview? = nil,
        returnUrl: String? = nil,
        setupFutureUsage: SetupFutureUsage? = nil,
        setupIntent: Stripe.Setup.Intent.ID? = nil,
        shipping: Shipping? = nil,
        useStripeSdk: Bool? = nil
    ) {
        self.id = id
        self.object = object
        self.created = created
        self.expiresAt = expiresAt
        self.livemode = livemode
        self.mandateData = mandateData
        self.paymentIntent = paymentIntent
        self.paymentMethodPreview = paymentMethodPreview
        self.returnUrl = returnUrl
        self.setupFutureUsage = setupFutureUsage
        self.setupIntent = setupIntent
        self.shipping = shipping
        self.useStripeSdk = useStripeSdk
    }
}

// MARK: - Nested Types

extension ConfirmationToken {
    public struct MandateData: Codable, Hashable, Sendable {
        /// This hash contains details about the customer acceptance of the Mandate.
        public var customerAcceptance: CustomerAcceptance?

        private enum CodingKeys: String, CodingKey {
            case customerAcceptance = "customer_acceptance"
        }

        public init(customerAcceptance: CustomerAcceptance? = nil) {
            self.customerAcceptance = customerAcceptance
        }
    }

    public struct CustomerAcceptance: Codable, Hashable, Sendable {
        /// The time that the customer accepts the Mandate.
        public var acceptedAt: Date?
        /// If this is a Mandate accepted online, this hash contains details about the online acceptance.
        public var online: OnlineAcceptance?
        /// The type of customer acceptance information included with the Mandate.
        public var type: AcceptanceType?

        private enum CodingKeys: String, CodingKey {
            case acceptedAt = "accepted_at"
            case online
            case type
        }

        public init(
            acceptedAt: Date? = nil,
            online: OnlineAcceptance? = nil,
            type: AcceptanceType? = nil
        ) {
            self.acceptedAt = acceptedAt
            self.online = online
            self.type = type
        }
    }

    public struct OnlineAcceptance: Codable, Hashable, Sendable {
        /// The IP address from which the Mandate was accepted by the customer.
        public var ipAddress: String?
        /// The user agent of the browser from which the Mandate was accepted by the customer.
        public var userAgent: String?

        private enum CodingKeys: String, CodingKey {
            case ipAddress = "ip_address"
            case userAgent = "user_agent"
        }

        public init(ipAddress: String? = nil, userAgent: String? = nil) {
            self.ipAddress = ipAddress
            self.userAgent = userAgent
        }
    }

    public enum AcceptanceType: String, Codable, Sendable {
        case offline
        case online
    }

    public enum SetupFutureUsage: String, Codable, Sendable {
        case offSession = "off_session"
        case onSession = "on_session"
    }

    /// Payment method preview - simplified version as full details would be extensive
    public struct PaymentMethodPreview: Codable, Hashable, Sendable {
        /// The type of the PaymentMethod.
        public var type: String?
        /// Billing information associated with the PaymentMethod.
        public var billingDetails: BillingModel.Details?

        private enum CodingKeys: String, CodingKey {
            case type
            case billingDetails = "billing_details"
        }

        public init(type: String? = nil, billingDetails: BillingModel.Details? = nil) {
            self.type = type
            self.billingDetails = billingDetails
        }
    }

    public struct Shipping: Codable, Hashable, Sendable {
        /// Recipient address.
        public var address: Address?
        /// Recipient name.
        public var name: String?
        /// Recipient phone (including extension).
        public var phone: String?

        public init(address: Address? = nil, name: String? = nil, phone: String? = nil) {
            self.address = address
            self.name = name
            self.phone = phone
        }
    }
}
