import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Customers.Cards {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/cards/create.md
        case create(customerId: Stripe.Customers.Customer.ID, request: Create.Request)
        // https://docs.stripe.com/api/cards/retrieve.md
        case retrieve(customerId: Stripe.Customers.Customer.ID, cardId: Card.ID)
        // https://docs.stripe.com/api/cards/update.md
        case update(
            customerId: Stripe.Customers.Customer.ID,
            cardId: Card.ID,
            request: Update.Request
        )
        // https://docs.stripe.com/api/cards/list.md
        case list(customerId: Stripe.Customers.Customer.ID, request: List.Request)
        // https://docs.stripe.com/api/cards/delete.md
        case delete(customerId: Stripe.Customers.Customer.ID, cardId: Card.ID)
    }
}

extension Stripe.Customers.Cards.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Customers.Cards.API> {
            OneOf {
                Route(.case(Stripe.Customers.Cards.API.create)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Body(
                        .form(
                            Stripe.Customers.Cards.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Customers.Cards.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cards
                    Path { Parse(.string.representing(Card.ID.self)) }
                }

                Route(.case(Stripe.Customers.Cards.API.update)) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(Card.ID.self)) }
                    Body(
                        .form(
                            Stripe.Customers.Cards.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Customers.Cards.API.list)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cards
                    Parse(.memberwise(Stripe.Customers.Cards.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
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

                Route(.case(Stripe.Customers.Cards.API.delete)) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(Card.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var cards: Path<PathBuilder.Component<String>> { Path {
        "cards"
    } }
}
