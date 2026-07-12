import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Connect.Transfers {
    @Cases
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
                Route(.case(Stripe.Connect.Transfers.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.transfers
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Transfers.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Transfers.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Connect.Transfers.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.transfers
                    Path { Parse(.string.representing(Stripe.Connect.Transfer.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.Transfers.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Connect.Transfers.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.transfers
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0.0, $0.0.0.0.0.1, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { ((((($0.0, $0.1), $0.2), $0.3), $0.4), $0.5) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Connect.Transfers.List.Request.init,
                                { ($0.created, $0.destination, $0.endingBefore, $0.limit, $0.startingAfter, $0.transferGroup) }
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
                                Field("destination") {
                                    Parse(.string.representing(Stripe.Connect.Account.ID.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
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
