import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Billing.TaxIDs {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/customer_tax_ids/create
        case create(customerId: Stripe.Customers.Customer.ID, request: Create.Request)
        // https://docs.stripe.com/api/customer_tax_ids/retrieve
        case retrieve(customerId: Stripe.Customers.Customer.ID, id: TaxID.ID)
        // https://docs.stripe.com/api/customer_tax_ids/delete
        case delete(customerId: Stripe.Customers.Customer.ID, id: TaxID.ID)
        // https://docs.stripe.com/api/customer_tax_ids/list
        case list(customerId: Stripe.Customers.Customer.ID, request: List.Request)
    }
}

extension Stripe.Billing.TaxIDs.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.TaxIDs.API> {
            OneOf {
                URLRouting.Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Billing.TaxIDs.API.cases.create))) {
                    Method.post
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.tax_ids
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.TaxIDs.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.convert(
                        apply: { (customerId: $0.0, id: $0.1) },
                        unapply: { ($0.customerId, $0.id) }
                    )
                    .map(.case(Stripe.Billing.TaxIDs.API.cases.retrieve))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.tax_ids
                    Path { Parse(.string.representing(Stripe.Billing.TaxIDs.TaxID.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (customerId: $0.0, id: $0.1) },
                        unapply: { ($0.customerId, $0.id) }
                    )
                    .map(.case(Stripe.Billing.TaxIDs.API.cases.delete))) {
                    Method.delete
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.tax_ids
                    Path { Parse(.string.representing(Stripe.Billing.TaxIDs.TaxID.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (customerId: $0.0, request: $0.1) },
                        unapply: { ($0.customerId, $0.request) }
                    )
                    .map(.case(Stripe.Billing.TaxIDs.API.cases.list))) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.tax_ids
                    Parse(
                        .convert(
                            apply: { ($0.0.0, $0.0.1, $0.1) },
                            unapply: { (($0.0, $0.1), $0.2) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.TaxIDs.List.Request.init,
                                { ($0.endingBefore, $0.limit, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
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
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    package static var tax_ids: Path<PathBuilder.Component<String>> { Path { "tax_ids" } }
}
