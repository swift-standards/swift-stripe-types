//
//  TransferReversal.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/transfer_reversals/object.md

extension Stripe.Connect.Transfer {
    /// The [Transfer Reversal Object](https://stripe.com/docs/api/transfer_reversals/object) .
    public struct Reversal: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// Amount, in cents.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// ID of the transfer that was reversed.
        @ExpandableOf<Stripe.Connect.Transfer> public var transfer: Stripe.Connect.Transfer.ID?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Balance transaction that describes the impact on your account balance.
        @ExpandableOf<Stripe.Balance.Transaction> public var balanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Linked payment refund for the transfer reversal.
        @ExpandableOf<Stripe.Refunds.Refund> public var destinationPaymentRefund:
            Stripe.Refunds.Refund.ID?
        /// ID of the refund responsible for the transfer reversal.
        @ExpandableOf<Stripe.Refunds.Refund> public var sourceRefund: Stripe.Refunds.Refund.ID?

        public init(
            id: ID,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            metadata: [String: String]? = nil,
            transfer: Stripe.Connect.Transfer.ID? = nil,
            object: String,
            balanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            created: Date,
            destinationPaymentRefund: Stripe.Refunds.Refund.ID? = nil,
            sourceRefund: Stripe.Refunds.Refund.ID? = nil
        ) {
            self.id = id
            self.amount = amount
            self.currency = currency
            self.metadata = metadata
            self._transfer = Expandable(id: transfer)
            self.object = object
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self._destinationPaymentRefund = Expandable(id: destinationPaymentRefund)
            self._sourceRefund = Expandable(id: sourceRefund)
        }
    }
}

extension Stripe.Connect.Transfer.Reversal {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Transfer.Reversal]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Transfer.Reversal]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
