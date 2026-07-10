import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers {
    public enum CashBalance: Sendable {}
}

extension Stripe.Customers.CashBalance {
    // https://docs.stripe.com/api/cash_balance/update.md
    public enum Update {}
}

extension Stripe.Customers.CashBalance.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Settings for the customer's cash balance.
        public let settings: Settings?

        public init(
            settings: Settings? = nil
        ) {
            self.settings = settings
        }

        public struct Settings: Codable, Equatable, Sendable {
            /// Controls how funds are applied to invoices when the customer makes a payment.
            public let reconciliationMode: ReconciliationMode?

            private enum CodingKeys: String, CodingKey {
                case reconciliationMode = "reconciliation_mode"
            }

            public init(
                reconciliationMode: ReconciliationMode? = nil
            ) {
                self.reconciliationMode = reconciliationMode
            }

            public enum ReconciliationMode: String, Codable, Sendable {
                case automatic
                case manual
                case merchantDefault = "merchant_default"
            }
        }
    }
}
