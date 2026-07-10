import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Billing.Alerts {
    public struct Alert: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        public let id: ID
        public let object: String
        public let alertType: AlertType
        public let livemode: Bool
        public let status: Status?
        public let title: String
        public let usageThreshold: UsageThreshold?

        public enum AlertType: String, Codable, Equatable, Sendable {
            case usageThreshold = "usage_threshold"
        }

        public enum Status: String, Codable, Equatable, Sendable {
            case active
            case archived
            case inactive
        }

        public struct UsageThreshold: Codable, Equatable, Sendable {
            public let filters: [Filter]?
            public let gte: Int
            public let meter: String
            public let recurrence: Recurrence

            public struct Filter: Codable, Equatable, Sendable {
                public let customer: Stripe.Customers.Customer.ID?
                public let type: FilterType

                public enum FilterType: String, Codable, Equatable, Sendable {
                    case customer
                }
            }

            public enum Recurrence: String, Codable, Equatable, Sendable {
                case oneTime = "one_time"
            }
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case object
            case alertType = "alert_type"
            case livemode
            case status
            case title
            case usageThreshold = "usage_threshold"
        }
    }
}

// MARK: - Create
extension Stripe.Billing.Alerts {
    public enum Create {}
}

extension Stripe.Billing.Alerts.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The type of alert to create.
        public let alertType: Stripe.Billing.Alerts.Alert.AlertType

        /// The title of the alert.
        public let title: String

        /// The usage threshold settings for the alert.
        public let usageThreshold: UsageThreshold?

        public struct UsageThreshold: Codable, Equatable, Sendable {
            /// The filters to apply to the alert.
            public let filters: [Filter]?

            /// The value at which this alert will trigger.
            public let gte: Int

            /// The meter to monitor.
            public let meter: String

            /// Frequency at which this alert recurs.
            public let recurrence: Stripe.Billing.Alerts.Alert.UsageThreshold.Recurrence

            public struct Filter: Codable, Equatable, Sendable {
                /// Limit the scope of the alert to this customer ID.
                public let customer: Stripe.Customers.Customer.ID?

                /// The type of filter.
                public let type: Stripe.Billing.Alerts.Alert.UsageThreshold.Filter.FilterType
            }

            private enum CodingKeys: String, CodingKey {
                case filters
                case gte
                case meter
                case recurrence
            }
        }

        public init(
            alertType: Stripe.Billing.Alerts.Alert.AlertType,
            title: String,
            usageThreshold: UsageThreshold? = nil
        ) {
            self.alertType = alertType
            self.title = title
            self.usageThreshold = usageThreshold
        }

        private enum CodingKeys: String, CodingKey {
            case alertType = "alert_type"
            case title
            case usageThreshold = "usage_threshold"
        }
    }
}

// MARK: - List
extension Stripe.Billing.Alerts {
    public enum List {}
}

extension Stripe.Billing.Alerts.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Filter by alert type.
        public let alertType: Stripe.Billing.Alerts.Alert.AlertType?

        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?

        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?

        /// Filter by meter.
        public let meter: String?

        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            alertType: Stripe.Billing.Alerts.Alert.AlertType? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            meter: String? = nil,
            startingAfter: String? = nil
        ) {
            self.alertType = alertType
            self.endingBefore = endingBefore
            self.limit = limit
            self.meter = meter
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case alertType = "alert_type"
            case endingBefore = "ending_before"
            case limit
            case meter
            case startingAfter = "starting_after"
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.Alerts.Alert]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
