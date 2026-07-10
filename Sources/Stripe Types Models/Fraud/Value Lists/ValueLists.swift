//
//  ValueLists.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/radar/value_lists/object.md

extension Stripe.Fraud.ValueLists {
    /// The [Value List](https://stripe.com/docs/api/radar/value_lists/object)
    public struct ValueList: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// The name of the value list for use in rules.
        public var alias: String?
        /// The type of items in the value list. One of `card_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`,  `case_sensitive_string` or `customer_id`.
        public var itemType: ItemType?
        /// List of items contained within this value list.
        public var listItems: ListItems?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The name of the value list.
        public var name: String?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// The name or email address of the user who added this item to the value list.
        public var createdBy: String?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?

        public init(
            id: ID,
            alias: String? = nil,
            itemType: ItemType? = nil,
            listItems: ListItems? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            object: String,
            created: Date,
            createdBy: String? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.alias = alias
            self.itemType = itemType
            self.listItems = listItems
            self.metadata = metadata
            self.name = name
            self.object = object
            self.created = created
            self.createdBy = createdBy
            self.livemode = livemode
        }
    }

    public enum ItemType: String, Codable, Sendable {
        case cardFingerprint = "card_fingerprint"
        case cardBin = "card_bin"
        case email
        case ipAddress = "ip_address"
        case country
        case string
        case caseSensitiveString = "case_sensitive_string"
        case customerId = "customer_id"
    }

    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [ValueList]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [ValueList]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }

    public struct ListItems: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Fraud.ValueListItems.ValueListItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Fraud.ValueListItems.ValueListItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
