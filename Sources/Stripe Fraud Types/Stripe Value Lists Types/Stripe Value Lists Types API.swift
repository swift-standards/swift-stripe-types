import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting
import URLRouting

extension Stripe.Fraud.ValueLists {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/radar/value_lists/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/radar/value_lists/retrieve.md
        case retrieve(id: ValueList.ID)
        // https://docs.stripe.com/api/radar/value_lists/update.md
        case update(id: ValueList.ID, request: Update.Request)
        // https://docs.stripe.com/api/radar/value_lists/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/radar/value_lists/delete.md
        case delete(id: ValueList.ID)
    }
}

extension Stripe.Fraud.ValueLists.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Fraud.ValueLists.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Fraud.ValueLists.API.create)) {
                    Method.post
                    Path.v1
                    Path.radar
                    Path.valueLists
                    Body(
                        .form(
                            Stripe.Fraud.ValueLists.API.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Fraud.ValueLists.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.radar
                    Path.valueLists
                    Path { Parse(.string.representing(Stripe.Fraud.ValueLists.ValueList.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Fraud.ValueLists.API.update)) {
                    Method.post
                    Path.v1
                    Path.radar
                    Path.valueLists
                    Path { Parse(.string.representing(Stripe.Fraud.ValueLists.ValueList.ID.self)) }
                    Body(
                        .form(
                            Stripe.Fraud.ValueLists.API.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                //                URLRouting.Route(.case(Stripe.Fraud.ValueLists.API.list)) {
                //                    Method.get
                //                    Path.v1
                //                    Path.radar
                //                    Path.valueLists
                //                    Query {
                //                        Optionally {
                //                            Field("alias") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("contains") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("ending_before") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("limit") { Digits() }
                //                        }
                //                        Optionally {
                //                            Field("starting_after") { Parse(.string) }
                //                        }
                //                        Optionally {
                //                            Field("created", .inlineArray) { Stripe.DateFilter.queryParser() }
                //                        }
                //                    }
                //                    .query(Stripe.Fraud.ValueLists.API.List.Request?.self)
                //                }

                URLRouting.Route(.case(Stripe.Fraud.ValueLists.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.radar
                    Path.valueLists
                    Path { Parse(.string.representing(Stripe.Fraud.ValueLists.ValueList.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var valueLists: Path<PathBuilder.Component<String>> { Path {
        "value_lists"
    } }
}
