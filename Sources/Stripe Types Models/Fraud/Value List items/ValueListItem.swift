//
//  ValueListItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/radar/value_list_items/object.md

extension Stripe.Fraud.ValueListItems {
    /// The [Value List Item](https://stripe.com/docs/api/radar/value_list_items)
    public struct ValueListItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// The value of the item.
        public var value: String?
        /// The identifier of the value list this item belongs to.
        public var valueList: Stripe.Fraud.ValueLists.ValueList.ID?
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
            value: String? = nil,
            valueList: Stripe.Fraud.ValueLists.ValueList.ID? = nil,
            object: String,
            created: Date,
            createdBy: String? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.value = value
            self.valueList = valueList
            self.object = object
            self.created = created
            self.createdBy = createdBy
            self.livemode = livemode
        }
    }

    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [ValueListItem]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [ValueListItem]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
