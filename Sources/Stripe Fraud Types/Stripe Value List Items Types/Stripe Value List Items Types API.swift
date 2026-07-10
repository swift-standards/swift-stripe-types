import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting
import URLRouting

extension Stripe.Fraud.ValueListItems {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/radar/value_list_items/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/radar/value_list_items/retrieve.md
        case retrieve(id: ValueListItem.ID)
        // https://docs.stripe.com/api/radar/value_list_items/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/radar/value_list_items/delete.md
        case delete(id: ValueListItem.ID)
    }
}

extension Stripe.Fraud.ValueListItems.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Fraud.ValueListItems.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Fraud.ValueListItems.API.create)) {
                    Method.post
                    Path.v1
                    Path.radar
                    Path.valueListItems
                    Body(
                        .form(
                            Stripe.Fraud.ValueListItems.API.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Fraud.ValueListItems.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.radar
                    Path.valueListItems
                    Path {
                        Parse(
                            .string.representing(Stripe.Fraud.ValueListItems.ValueListItem.ID.self)
                        )
                    }
                }

                //                URLRouting.Route(.case(Stripe.Fraud.ValueListItems.API.list)) {
                //                    Method.get
                //                    Path.v1
                //                    Path.radar
                //                    Path.valueListItems
                //                    Query {
                //                        Optionally {
                //                            Field("value_list") { Parse(.string.representing(Stripe.Fraud.ValueLists.ValueList.ID.self)) }
                //                        }
                //                        Optionally {
                //                            Field("value") { Parse(.string) }
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
                //                    .query(Stripe.Fraud.ValueListItems.API.List.Request?.self)
                //                }

                URLRouting.Route(.case(Stripe.Fraud.ValueListItems.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.radar
                    Path.valueListItems
                    Path {
                        Parse(
                            .string.representing(Stripe.Fraud.ValueListItems.ValueListItem.ID.self)
                        )
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var valueListItems: Path<PathBuilder.Component<String>> { Path {
        "value_list_items"
    } }
}
