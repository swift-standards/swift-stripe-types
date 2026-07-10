//
//  Stripe Connect Accounts Types API.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Connect.Accounts {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/accounts/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/accounts/retrieve.md
        case retrieve(id: Stripe.Connect.Account.ID)
        // https://docs.stripe.com/api/accounts/update.md
        case update(id: Stripe.Connect.Account.ID, request: Update.Request)
        // https://docs.stripe.com/api/accounts/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/accounts/delete.md
        case delete(id: Stripe.Connect.Account.ID)
        // https://docs.stripe.com/api/accounts/reject.md
        case reject(id: Stripe.Connect.Account.ID, request: Reject.Request)
    }
}

extension Stripe.Connect.Accounts.API {
    public struct Router: ParserPrinter, Sendable {
        public var body: some URLRouting.Router<Stripe.Connect.Accounts.API> {
            OneOf {
                Route(.case(Stripe.Connect.Accounts.API.create)) {
                    Method.post
                    Path.v1
                    Path.accounts
                    Body(
                        .form(
                            Stripe.Connect.Accounts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Accounts.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                }

                Route(.case(Stripe.Connect.Accounts.API.update)) {
                    Method.post
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                    Body(
                        .form(
                            Stripe.Connect.Accounts.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Accounts.API.list)) {
                    Method.get
                    Path.v1
                    Path.accounts
                    Parse(.memberwise(Stripe.Connect.Accounts.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("expand") {
                                    Many { Parse(.string) }
                                }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Connect.Accounts.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                }

                Route(.case(Stripe.Connect.Accounts.API.reject)) {
                    Method.post
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                    Path.reject
                    Body(
                        .form(
                            Stripe.Connect.Accounts.Reject.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }

        public init() {}
    }

    public var router: Router {
        Router()
    }
}

extension Path<PathBuilder.Component<String>> {
    static var accounts: Path<PathBuilder.Component<String>> { Path {
        "accounts"
    } }

    static var reject: Path<PathBuilder.Component<String>> { Path {
        "reject"
    } }
}
