import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Fraud.ValueListItems.API {
    // https://docs.stripe.com/api/radar/value_list_items/create.md
    public enum Create {}
    // https://docs.stripe.com/api/radar/value_list_items/list.md
    public enum List {}
}

extension Stripe.Fraud.ValueListItems.API.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The value of the item (whose type must match the type of the parent value list).
        public var value: String
        /// The identifier of the value list which the created item will be added to.
        public var valueList: Stripe.Fraud.ValueLists.ValueList.ID

        private enum CodingKeys: String, CodingKey {
            case value
            case valueList = "value_list"
        }

        public init(
            value: String,
            valueList: Stripe.Fraud.ValueLists.ValueList.ID
        ) {
            self.value = value
            self.valueList = valueList
        }
    }
}

extension Stripe.Fraud.ValueListItems.API.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Identifier for the parent value list this item belongs to.
        public var valueList: Stripe.Fraud.ValueLists.ValueList.ID?
        /// Return items belonging to the parent list whose value matches the specified value.
        public var value: String?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?
        /// Only return value list items that were created during the given date interval.
        public var created: Stripe.DateFilter?

        private enum CodingKeys: String, CodingKey {
            case valueList = "value_list"
            case value
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
            case created
        }

        public init(
            valueList: Stripe.Fraud.ValueLists.ValueList.ID? = nil,
            value: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            created: Stripe.DateFilter? = nil
        ) {
            self.valueList = valueList
            self.value = value
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.created = created
        }
    }
}

extension Stripe.Fraud.ValueListItems.API.List {
    public struct Response: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Fraud.ValueListItems.ValueListItem]?
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
            data: [Stripe.Fraud.ValueListItems.ValueListItem]? = nil,
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
