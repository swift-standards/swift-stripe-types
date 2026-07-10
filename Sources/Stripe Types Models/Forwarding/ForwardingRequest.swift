//
//  ForwardingRequest.swift
//  Stripe Types
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/forwarding/request/object.md

extension Stripe.Forwarding {
    /// The [Forwarding Request Object](https://docs.stripe.com/api/forwarding/request/object).
    public struct Request: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The PaymentMethod to insert into the forwarded request. Forwarding previously consumed PaymentMethods is allowed.
        public var paymentMethod: String
        /// The field replacement set for this object.
        public var replacements: [Replacement]?
        /// Context about the request from Stripe's servers to the destination endpoint.
        public var requestContext: RequestContext?
        /// The request that was sent to the destination endpoint. We redact any sensitive fields.
        public var requestDetails: RequestDetails?
        /// The response that the destination endpoint returned to us. We redact any sensitive fields.
        public var responseDetails: ResponseDetails?
        /// The destination URL for the forwarded request. Must be supported by the config.
        public var url: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case created
            case livemode
            case metadata
            case paymentMethod = "payment_method"
            case replacements
            case requestContext = "request_context"
            case requestDetails = "request_details"
            case responseDetails = "response_details"
            case url
        }

        public init(
            id: ID,
            object: String,
            created: Date,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            paymentMethod: String,
            replacements: [Replacement]? = nil,
            requestContext: RequestContext? = nil,
            requestDetails: RequestDetails? = nil,
            responseDetails: ResponseDetails? = nil,
            url: String? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.livemode = livemode
            self.metadata = metadata
            self.paymentMethod = paymentMethod
            self.replacements = replacements
            self.requestContext = requestContext
            self.requestDetails = requestDetails
            self.responseDetails = responseDetails
            self.url = url
        }
    }
}

// MARK: - Nested Types

extension Stripe.Forwarding.Request {
    public enum Replacement: String, Codable, Sendable {
        case cardCvc = "card_cvc"
        case cardExpiry = "card_expiry"
        case cardNumber = "card_number"
        case cardholderName = "cardholder_name"
        case requestSignature = "request_signature"
    }

    public struct RequestContext: Codable, Hashable, Sendable {
        /// The time it took in milliseconds for the destination endpoint to respond.
        public var destinationDuration: Int?
        /// The IP address of the destination endpoint.
        public var destinationIpAddress: String?

        private enum CodingKeys: String, CodingKey {
            case destinationDuration = "destination_duration"
            case destinationIpAddress = "destination_ip_address"
        }

        public init(
            destinationDuration: Int? = nil,
            destinationIpAddress: String? = nil
        ) {
            self.destinationDuration = destinationDuration
            self.destinationIpAddress = destinationIpAddress
        }
    }

    public struct RequestDetails: Codable, Hashable, Sendable {
        /// The body payload to send to the destination endpoint.
        public var body: String?
        /// HTTP headers that should be included in the request sent to the destination endpoint.
        public var headers: [Header]?
        /// The HTTP method used to call the destination endpoint.
        public var httpMethod: HTTPMethod?

        private enum CodingKeys: String, CodingKey {
            case body
            case headers
            case httpMethod = "http_method"
        }

        public init(
            body: String? = nil,
            headers: [Header]? = nil,
            httpMethod: HTTPMethod? = nil
        ) {
            self.body = body
            self.headers = headers
            self.httpMethod = httpMethod
        }
    }

    public struct ResponseDetails: Codable, Hashable, Sendable {
        /// The response body returned by the destination endpoint.
        public var body: String?
        /// HTTP headers returned by the destination endpoint.
        public var headers: [Header]?
        /// The HTTP status code returned by the destination endpoint.
        public var status: Int?

        public init(
            body: String? = nil,
            headers: [Header]? = nil,
            status: Int? = nil
        ) {
            self.body = body
            self.headers = headers
            self.status = status
        }
    }

    public struct Header: Codable, Hashable, Sendable {
        /// The header name.
        public var name: String?
        /// The header value.
        public var value: String?

        public init(name: String? = nil, value: String? = nil) {
            self.name = name
            self.value = value
        }
    }

    public enum HTTPMethod: String, Codable, Sendable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}
