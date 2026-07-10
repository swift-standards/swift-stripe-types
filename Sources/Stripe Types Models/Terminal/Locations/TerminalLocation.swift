//
//  TerminalLocation.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/terminal/locations/object.md

extension Stripe.Terminal.Locations {
    /// The [Location Object](https://stripe.com/docs/api/terminal/locations/object)
    public struct Location: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// The full address of the location.
        public var address: Address?
        /// The display name of the location.
        public var displayName: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// The ID of a configuration that will be used to customize all readers in this location.
        public var configurationOverrides: String?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?

        public init(
            id: ID,
            address: Address? = nil,
            displayName: String? = nil,
            metadata: [String: String]? = nil,
            object: String,
            configurationOverrides: String? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.address = address
            self.displayName = displayName
            self.metadata = metadata
            self.object = object
            self.configurationOverrides = configurationOverrides
            self.livemode = livemode
        }
    }
}
