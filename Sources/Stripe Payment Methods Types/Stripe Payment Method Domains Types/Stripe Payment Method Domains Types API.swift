import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.PaymentMethodDomains {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payment_method_domains/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/payment_method_domains/retrieve.md
        case retrieve(id: Stripe.PaymentMethodDomain.ID)
        // https://docs.stripe.com/api/payment_method_domains/update.md
        case update(id: Stripe.PaymentMethodDomain.ID, request: Update.Request)
        // https://docs.stripe.com/api/payment_method_domains/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/payment_method_domains/validate.md
        case validate(id: Stripe.PaymentMethodDomain.ID)
    }
}

extension Stripe.PaymentMethodDomains.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentMethodDomains.API> {
            OneOf {
                Route(.case(Stripe.PaymentMethodDomains.API.create)) {
                    Method.post
                    Path.v1
                    Path.paymentMethodDomains
                    Body(
                        .form(
                            Stripe.PaymentMethodDomains.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethodDomains.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.paymentMethodDomains
                    Path { Parse(.string.representing(Stripe.PaymentMethodDomain.ID.self)) }
                }

                Route(.case(Stripe.PaymentMethodDomains.API.update)) {
                    Method.post
                    Path.v1
                    Path.paymentMethodDomains
                    Path { Parse(.string.representing(Stripe.PaymentMethodDomain.ID.self)) }
                    Body(
                        .form(
                            Stripe.PaymentMethodDomains.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethodDomains.API.list)) {
                    Method.get
                    Path.v1
                    Path.paymentMethodDomains
                    Parse(.memberwise(Stripe.PaymentMethodDomains.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("domain_name") { Parse(.string) }
                            }
                            Optionally {
                                Field("enabled") { Bool.parser() }
                            }
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

                Route(.case(Stripe.PaymentMethodDomains.API.validate)) {
                    Method.post
                    Path.v1
                    Path.paymentMethodDomains
                    Path { Parse(.string.representing(Stripe.PaymentMethodDomain.ID.self)) }
                    Path.validate
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var paymentMethodDomains: Path<PathBuilder.Component<String>> { Path {
        "payment_method_domains"
    } }

    public static var validate: Path<PathBuilder.Component<String>> { Path {
        "validate"
    } }
}
