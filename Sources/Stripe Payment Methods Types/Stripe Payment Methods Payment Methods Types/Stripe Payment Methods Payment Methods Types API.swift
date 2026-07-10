import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.PaymentMethods.PaymentMethods {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payment_methods/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/payment_methods/retrieve.md
        case retrieve(id: Stripe.PaymentMethods.PaymentMethod.ID)
        // https://docs.stripe.com/api/payment_methods/retrieve_customer.md
        case retrieveCustomer(
            customerId: Stripe.Customers.Customer.ID,
            paymentMethodId: Stripe.PaymentMethods.PaymentMethod.ID
        )
        // https://docs.stripe.com/api/payment_methods/update.md
        case update(id: Stripe.PaymentMethods.PaymentMethod.ID, request: Update.Request)
        // https://docs.stripe.com/api/payment_methods/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/payment_methods/customer_list.md
        case listCustomer(customerId: Stripe.Customers.Customer.ID, request: List.Customer.Request)
        // https://docs.stripe.com/api/payment_methods/attach.md
        case attach(id: Stripe.PaymentMethods.PaymentMethod.ID, request: Attach.Request)
        // https://docs.stripe.com/api/payment_methods/detach.md
        case detach(id: Stripe.PaymentMethods.PaymentMethod.ID)
    }
}

extension Stripe.PaymentMethods.PaymentMethods.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentMethods.PaymentMethods.API> {
            OneOf {
                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.create)) {
                    Method.post
                    Path.v1
                    Path.payment_methods
                    Body(
                        .form(
                            Stripe.PaymentMethods.PaymentMethods.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.payment_methods
                    Path {
                        Parse(.string.representing(Stripe.PaymentMethods.PaymentMethod.ID.self))
                    }
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.retrieveCustomer)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.payment_methods
                    Path {
                        Parse(.string.representing(Stripe.PaymentMethods.PaymentMethod.ID.self))
                    }
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.update)) {
                    Method.post
                    Path.v1
                    Path.payment_methods
                    Path {
                        Parse(.string.representing(Stripe.PaymentMethods.PaymentMethod.ID.self))
                    }
                    Body(
                        .form(
                            Stripe.PaymentMethods.PaymentMethods.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.list)) {
                    Method.get
                    Path.v1
                    Path.payment_methods
                    Parse(.memberwise(Stripe.PaymentMethods.PaymentMethods.List.Request.init)) {
                        Query {
                            Optionally {
                                Field("customer") {
                                    Parse(.string.representing(Stripe.Customers.Customer.ID.self))
                                }
                            }
                            Optionally {
                                Field("type") { Parse(.string) }
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

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.listCustomer)) {
                    Method.get
                    Path.v1
                    Path.customers
                    Path { Parse(.string.representing(Stripe.Customers.Customer.ID.self)) }
                    Path.payment_methods
                    Parse(
                        .memberwise(Stripe.PaymentMethods.PaymentMethods.List.Customer.Request.init)
                    ) {
                        Query {
                            Optionally {
                                Field("type") { Parse(.string) }
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
                            Optionally {
                                Field("allow_redisplay") { Parse(.string) }
                            }
                        }
                    }
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.attach)) {
                    Method.post
                    Path.v1
                    Path.payment_methods
                    Path {
                        Parse(.string.representing(Stripe.PaymentMethods.PaymentMethod.ID.self))
                    }
                    Path.attach
                    Body(
                        .form(
                            Stripe.PaymentMethods.PaymentMethods.Attach.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethods.PaymentMethods.API.detach)) {
                    Method.post
                    Path.v1
                    Path.payment_methods
                    Path {
                        Parse(.string.representing(Stripe.PaymentMethods.PaymentMethod.ID.self))
                    }
                    Path.detach
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var payment_methods: Path<PathBuilder.Component<String>> { Path {
        "payment_methods"
    } }
    public static var customers: Path<PathBuilder.Component<String>> { Path {
        "customers"
    } }
    public static var attach: Path<PathBuilder.Component<String>> { Path {
        "attach"
    } }
    public static var detach: Path<PathBuilder.Component<String>> { Path {
        "detach"
    } }
}
