//
//  Stripe Connect Accounts Types API.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Connect.Accounts {
    @Cases
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
                Route(.case(Stripe.Connect.Accounts.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.accounts
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Accounts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Accounts.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Connect.Accounts.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Accounts.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Accounts.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.accounts
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Connect.Accounts.List.Request.init,
                                { ($0.created, $0.endingBefore, $0.expand, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
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
                                    // swift-parsing `Many` dissolved onto the vended conversion seam:
                                    // parse wraps the whole field value as a single element; print joins
                                    // (identical to the original `Many { Parse(.string) }` degenerate
                                    // no-separator behavior over a field value).
                                    Parse(.string).map(.convert(apply: { [$0] }, unapply: { $0.joined() }))
                                }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.Connect.Accounts.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Connect.Accounts.API.cases.reject))) {
                    Method.post
                    Path.v1
                    Path.accounts
                    Path { Parse(.string.representing(Stripe.Connect.Account.ID.self)) }
                    Path.reject
                    URLRouting.Body(
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
