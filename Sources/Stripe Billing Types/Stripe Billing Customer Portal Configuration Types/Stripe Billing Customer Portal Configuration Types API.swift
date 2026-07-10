import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Billing.Customer.Portal.Configuration {
    @CasePathable
    @dynamicMemberLookup
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
                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.create)) {
                    Method.post
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    Body(
                        .form(
                            Stripe.Billing.Customer.Portal.Configuration.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.retrieve)) {
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

                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.update)) {
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
                    Body(
                        .form(
                            Stripe.Billing.Customer.Portal.Configuration.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Customer.Portal.Configuration.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing_portal
                    Path.configurations
                    Parse(
                        .memberwise(Stripe.Billing.Customer.Portal.Configuration.List.Request.init)
                    ) {
                        Query {
                            Optionally {
                                Field("active") { Parsers.BoolParser() }
                            }
                            Optionally {
                                Field("is_default") { Parsers.BoolParser() }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Digits() }
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
