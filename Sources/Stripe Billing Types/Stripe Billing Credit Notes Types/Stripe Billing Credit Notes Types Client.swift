//
//  Stripe Billing Credit Notes Types Client.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared

extension Stripe.Billing.CreditNotes {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/credit_notes/create.md
        public var create:
            @Sendable (_ request: Stripe.Billing.CreditNotes.Create.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Credit.Note

        // https://docs.stripe.com/api/credit_notes/update.md
        public var update:
            @Sendable (
                _ id: Stripe.Billing.Credit.Note.ID,
                _ request: Stripe.Billing.CreditNotes.Update.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Credit.Note

        // https://docs.stripe.com/api/credit_notes/retrieve.md
        public var retrieve:
            @Sendable (_ id: Stripe.Billing.Credit.Note.ID) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Credit.Note

        // https://docs.stripe.com/api/credit_notes/list.md
        public var list:
            @Sendable (_ request: Stripe.Billing.CreditNotes.List.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.CreditNotes.List.Response

        // https://docs.stripe.com/api/credit_notes/preview.md
        public var preview:
            @Sendable (_ request: Stripe.Billing.CreditNotes.Preview.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.Credit.Note

        // https://docs.stripe.com/api/credit_notes/void.md
        public var void:
            @Sendable (
                _ id: Stripe.Billing.Credit.Note.ID,
                _ request: Stripe.Billing.CreditNotes.Void.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.Credit.Note

        // https://docs.stripe.com/api/credit_notes/lines.md
        public var lines:
            @Sendable (
                _ id: Stripe.Billing.Credit.Note.ID,
                _ request: Stripe.Billing.CreditNotes.Lines.Request
            ) async throws(Witness.Unimplemented.Error) -> Stripe.Billing.CreditNotes.Lines.Response

        // https://docs.stripe.com/api/credit_notes/preview_lines.md
        public var previewLines:
            @Sendable (_ request: Stripe.Billing.CreditNotes.PreviewLines.Request) async throws(Witness.Unimplemented.Error) ->
                Stripe.Billing.CreditNotes.PreviewLines.Response
    }
}
