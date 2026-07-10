import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Connect.Transfers {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/transfers/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/transfers/retrieve.md
        case retrieve(id: Stripe.Connect.Transfer.ID)
        // https://docs.stripe.com/api/transfers/update.md
        case update(id: Stripe.Connect.Transfer.ID, request: Update.Request)
        // https://docs.stripe.com/api/transfers/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Connect.Transfers.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Connect.Transfers.API> {
            OneOf {
                Route(.case(Stripe.Connect.Transfers.API.create)) {
                    Method.post
                    Path.v1
                    Path.transfers
                    Body(
                        .form(
                            Stripe.Connect.Transfers.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Transfers.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                }

                Route(.case(Stripe.Connect.Transfers.API.update)) {
                    Method.post
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    Body(
                        .form(
                            Stripe.Connect.Transfers.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Transfers.API.list)) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Parse(.memberwise(Stripe.Connect.Transfers.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("destination") {
                                    Parse(.string.representing(Stripe.Connect.Account.ID.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("transfer_group") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var transfers: Path<PathBuilder.Component<String>> { Path {
        "transfers"
    } }
}
