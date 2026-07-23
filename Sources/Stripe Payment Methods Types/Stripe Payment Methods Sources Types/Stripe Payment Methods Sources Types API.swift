import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.PaymentMethods.Sources {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/sources/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/sources/retrieve.md
        case retrieve(id: Stripe_Types_Models.Source.ID)
        // https://docs.stripe.com/api/sources/update.md
        case update(id: Stripe_Types_Models.Source.ID, request: Update.Request)
        // https://docs.stripe.com/api/sources/attach.md
        case attach(customerId: Stripe.Customers.Customer.ID, source: Stripe_Types_Models.Source.ID)
        // https://docs.stripe.com/api/sources/detach.md
        case detach(customerId: Stripe.Customers.Customer.ID, sourceId: Stripe_Types_Models.Source.ID)
    }
}

extension Stripe.PaymentMethods.Sources.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentMethods.Sources.API> {
            OneOf {
                Route(.case(Stripe.PaymentMethods.Sources.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.sources
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentMethods.Sources.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethods.Sources.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.sources
                    Path { Parse(.string.representing(Stripe_Types_Models.Source.ID.self)) }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.PaymentMethods.Sources.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.sources
                    Path { Parse(.string.representing(Stripe_Types_Models.Source.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentMethods.Sources.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.convert(
                        apply: { (customerId: $0.0, source: $0.1) },
                        unapply: { ($0.customerId, $0.source) }
                    )
                    .map(.case(Stripe.PaymentMethods.Sources.API.cases.attach))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Query {
                        Field("source") { Parse(.string.representing(Stripe_Types_Models.Source.ID.self)) }
                    }
                }

                Route(.convert(
                        apply: { (customerId: $0.0, sourceId: $0.1) },
                        unapply: { ($0.customerId, $0.sourceId) }
                    )
                    .map(.case(Stripe.PaymentMethods.Sources.API.cases.detach))) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.sources
                    Path { Parse(.string.representing(Stripe_Types_Models.Source.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var sources: Path<PathBuilder.Component<String>> { Path {
        "sources"
    } }
}
