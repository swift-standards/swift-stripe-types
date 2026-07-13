import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URL_Routing_Form_Coding

extension Stripe.Billing.Customer.Portal.Configuration {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/customer_portal/configurations/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/customer_portal/configurations/retrieve.md
        case retrieve(id: Stripe.Billing.Customer.Portal.Configuration.ID)
        // https://docs.stripe.com/api/customer_portal/configurations/update.md
        case update(id: Stripe.Billing.Customer.Portal.Configuration.ID, request: Update.Request)
        // https://docs.stripe.com/api/customer_portal/configurations/list.md
        case list(request: List.Request)
    }
}

extension Stripe.Billing.Customer.Portal.Configuration.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Customer.Portal.Configuration.API> {
            OneOf {
                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Customer.Portal.Configuration.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.Customer.Portal.Configuration.ID.self
                            )
                        )
                    }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Billing.Customer.Portal.Configuration.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.Billing.Customer.Portal.Configuration.ID.self
                            )
                        )
                    }
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Customer.Portal.Configuration.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(Stripe.Billing.Customer.Portal.Configuration.List.Request.init, { ($0.active, $0.isDefault, $0.endingBefore, $0.startingAfter, $0.limit) })
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("active") { Bool.parser() }
                            }
                            Optionally {
                                Field("is_default") { Bool.parser() }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var configurations: Path<PathBuilder.Component<String>> { Path {
        "configurations"
    } }
}
