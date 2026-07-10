//
//  Stripe Billing Credit Notes Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.CreditNotes {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/credit_notes/create.md
        case create(request: Stripe.Billing.CreditNotes.Create.Request)
        // https://docs.stripe.com/api/credit_notes/update.md
        case update(
            id: Stripe.Billing.Credit.Note.ID,
            request: Stripe.Billing.CreditNotes.Update.Request
        )
        // https://docs.stripe.com/api/credit_notes/retrieve.md
        case retrieve(id: Stripe.Billing.Credit.Note.ID)
        // https://docs.stripe.com/api/credit_notes/list.md
        case list(request: Stripe.Billing.CreditNotes.List.Request)
        // https://docs.stripe.com/api/credit_notes/preview.md
        case preview(request: Stripe.Billing.CreditNotes.Preview.Request)
        // https://docs.stripe.com/api/credit_notes/void.md
        case void(
            id: Stripe.Billing.Credit.Note.ID,
            request: Stripe.Billing.CreditNotes.Void.Request
        )
        // https://docs.stripe.com/api/credit_notes/lines.md
        case lines(
            id: Stripe.Billing.Credit.Note.ID,
            request: Stripe.Billing.CreditNotes.Lines.Request
        )
        // https://docs.stripe.com/api/credit_notes/preview_lines.md
        case previewLines(request: Stripe.Billing.CreditNotes.PreviewLines.Request)
    }
}

extension Stripe.Billing.CreditNotes.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.CreditNotes.API> {
            OneOf {
                // https://docs.stripe.com/api/credit_notes/create.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.create)) {
                    Method.post
                    Path.v1
                    Path.credit_notes
                    Body(
                        .form(
                            Stripe.Billing.CreditNotes.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/credit_notes/update.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.update)) {
                    Method.post
                    Path.v1
                    Path.credit_notes
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Note.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.CreditNotes.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/credit_notes/retrieve.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.credit_notes
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Note.ID.self)) }
                }

                // https://docs.stripe.com/api/credit_notes/list.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.list)) {
                    Method.get
                    Path.v1
                    Path.credit_notes
                    Parse(.memberwise(Stripe.Billing.CreditNotes.List.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
                            }
                            Optionally {
                                Field("invoice") {
                                    Parse(.string.representing(Stripe.Billing.Invoice.ID.self))
                                }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/credit_notes/preview.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.preview)) {
                    Method.get
                    Path.v1
                    Path.credit_notes
                    Path.preview
                    Parse(.memberwise(Stripe.Billing.CreditNotes.Preview.Request.init)) {
                        URLRouting.Query {
                            Field("invoice") {
                                Parse(.string.representing(Stripe.Billing.Invoice.ID.self))
                            }
                            Optionally {
                                Field("amount") { Digits() }
                            }
                            Optionally {
                                Field("credit_amount") { Digits() }
                            }
                            Optionally {
                                Field("memo") { Parse(.string) }
                            }
                            Optionally {
                                Field("reason") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/credit_notes/void.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.void)) {
                    Method.post
                    Path.v1
                    Path.credit_notes
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Note.ID.self)) }
                    Path.voidPath
                    Body(
                        .form(
                            Stripe.Billing.CreditNotes.Void.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // https://docs.stripe.com/api/credit_notes/lines.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.lines)) {
                    Method.get
                    Path.v1
                    Path.credit_notes
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Note.ID.self)) }
                    Path.lines
                    Parse(.memberwise(Stripe.Billing.CreditNotes.Lines.Request.init)) {
                        URLRouting.Query {
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                        }
                    }
                }

                // https://docs.stripe.com/api/credit_notes/preview_lines.md
                URLRouting.Route(.case(Stripe.Billing.CreditNotes.API.previewLines)) {
                    Method.get
                    Path.v1
                    Path.credit_notes
                    Path.preview
                    Path.lines
                    Parse(.memberwise(Stripe.Billing.CreditNotes.PreviewLines.Request.init)) {
                        URLRouting.Query {
                            Field("invoice") {
                                Parse(.string.representing(Stripe.Billing.Invoice.ID.self))
                            }
                            Optionally {
                                Field("amount") { Digits() }
                            }
                            Optionally {
                                Field("credit_amount") { Digits() }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var credit_notes: Path<PathBuilder.Component<String>> { Path {
        "credit_notes"
    } }

    public static var preview: Path<PathBuilder.Component<String>> { Path {
        "preview"
    } }

    public static var voidPath: Path<PathBuilder.Component<String>> { Path {
        "void"
    } }
}
