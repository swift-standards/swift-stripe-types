import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Credit.Grant {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/credit-grant/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/billing/credit-grant/retrieve.md
        case retrieve(id: ID)
        // https://docs.stripe.com/api/billing/credit-grant/update.md
        case update(id: ID, request: Update.Request)
        // https://docs.stripe.com/api/billing/credit-grant/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/billing/credit-grant/expire.md
        case expire(id: ID, request: Expire.Request)
        // https://docs.stripe.com/api/billing/credit-grant/void.md
        case void(id: ID, request: Void.Request)
    }
}

extension Stripe.Billing.Credit.Grant.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Credit.Grant.API> {
            OneOf {
                Route(.case(Stripe.Billing.Credit.Grant.API.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Body(
                        .form(
                            Stripe.Billing.Credit.Grant.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Credit.Grant.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Grant.ID.self)) }
                }

                Route(.case(Stripe.Billing.Credit.Grant.API.update)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Grant.ID.self)) }
                    Body(
                        .form(
                            Stripe.Billing.Credit.Grant.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Credit.Grant.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Parse(.memberwise(Stripe.Billing.Credit.Grant.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
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

                Route(.case(Stripe.Billing.Credit.Grant.API.expire)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Grant.ID.self)) }
                    Path.expire
                    Body(
                        .form(
                            Stripe.Billing.Credit.Grant.Expire.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.Billing.Credit.Grant.API.void)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.credit_grants
                    Path { Parse(.string.representing(Stripe.Billing.Credit.Grant.ID.self)) }
                    Path.void
                    Body(
                        .form(
                            Stripe.Billing.Credit.Grant.Void.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var credit_grants: Path<PathBuilder.Component<String>> { Path {
        "credit_grants"
    } }
    public static var expire: Path<PathBuilder.Component<String>> { Path {
        "expire"
    } }
}
