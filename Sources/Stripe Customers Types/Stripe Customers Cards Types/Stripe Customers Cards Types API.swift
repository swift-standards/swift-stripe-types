import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.Customers.Cards {
    @Cases
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
                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.Cards.API.cases.create))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.Cards.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (customerId: $0.0, cardId: $0.1) },
                        unapply: { ($0.customerId, $0.cardId) }
                    )
                    .map(.case(Stripe.Customers.Cards.API.cases.retrieve))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cards
                    Path { Parse(.string.representing(Card.ID.self)) }
                }

                Route(.convert(
                        apply: { (customerId: $0.0.0, cardId: $0.0.1, request: $0.1) },
                        unapply: { (($0.customerId, $0.cardId), $0.request) }
                    )
                    .map(.case(Stripe.Customers.Cards.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(Card.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Customers.Cards.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Customers.Cards.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.cards
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Customers.Cards.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("ending_before") { Parse(.string) }
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

                Route(.convert(
                        apply: { (customerId: $0.0, cardId: $0.1) },
                        unapply: { ($0.customerId, $0.cardId) }
                    )
                    .map(.case(Stripe.Customers.Cards.API.cases.delete))) {
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
