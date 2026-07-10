//
//  Transfer.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/transfers/object.md

extension Stripe.Connect {
    /// The [Transfer Object](https://stripe.com/docs/api/transfers/object) .
    public struct Transfer: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        /// Unique identifier for the object.
        public var id: ID
        /// Amount in cents to be transferred.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// An arbitrary string attached to the object. Often useful for displaying to users.
        public var description: String?
        /// ID of the Stripe account the transfer was sent to.
        @ExpandableOf<Stripe.Connect.Account> public var destination: Stripe.Connect.Account.ID?
        /// A set of key-value pairs that you can attach to a transfer object. It can be useful for storing additional information about the transfer in a structured format.
        public var metadata: [String: String]?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Amount in cents reversed (can be less than the amount attribute on the transfer if a partial reversal was issued).
        public var amountReversed: Int?
        /// Balance transaction that describes the impact of this transfer on your account balance.
        @ExpandableOf<Stripe.Balance.Transaction> public var balanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Time that this record of the transfer was first created.
        public var created: Date
        /// If the destination is a Stripe account, this will be the ID of the payment that the destination account received for the transfer.
        @ExpandableOf<Stripe.Charges.Charge> public var destinationPayment:
            Stripe.Charges.Charge.ID?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// A list of reversals that have been applied to the transfer.
        public var reversals: Stripe.Connect.Transfer.Reversal.List?
        /// Whether the transfer has been fully reversed. If the transfer is only partially reversed, this attribute will still be false.
        public var reversed: Bool?
        /// ID of the charge or payment that was used to fund the transfer. If null, the transfer was funded from the available balance.
        @ExpandableOf<Stripe.Charges.Charge> public var sourceTransaction: Stripe.Charges.Charge.ID?
        /// The source balance this transfer came from. One of `card`, `fpx` or `bank_account`.
        public var sourceType: Stripe.Connect.Transfer.SourceType?
        /// A string that identifies this transaction as part of a group. See the Connect documentation for details.
        public var transferGroup: String?

        public init(
            id: ID,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            description: String? = nil,
            destination: Stripe.Connect.Account.ID? = nil,
            metadata: [String: String]? = nil,
            object: String,
            amountReversed: Int? = nil,
            balanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            created: Date,
            destinationPayment: Stripe.Charges.Charge.ID? = nil,
            livemode: Bool? = nil,
            reversals: Stripe.Connect.Transfer.Reversal.List? = nil,
            reversed: Bool? = nil,
            sourceTransaction: Stripe.Charges.Charge.ID? = nil,
            sourceType: Stripe.Connect.Transfer.SourceType? = nil,
            transferGroup: String? = nil
        ) {
            self.id = id
            self.amount = amount
            self.currency = currency
            self.description = description
            self._destination = Expandable(id: destination)
            self.metadata = metadata
            self.object = object
            self.amountReversed = amountReversed
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self._destinationPayment = Expandable(id: destinationPayment)
            self.livemode = livemode
            self.reversals = reversals
            self.reversed = reversed
            self._sourceTransaction = Expandable(id: sourceTransaction)
            self.sourceType = sourceType
            self.transferGroup = transferGroup
        }
    }
}

extension Stripe.Connect.Transfer {
    public enum SourceType: String, Codable, Sendable {
        case card
        case fpx
        case bankAccount = "bank_account"
    }
}

extension Stripe.Connect.Transfer {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Transfer]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Transfer]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
