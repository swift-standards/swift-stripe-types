//
//  Stripe Payment Method Configurations Types API.swift
//  swift-stripe-types
//
//  Created for swift-stripe-types on 14/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.PaymentMethodConfigurations {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/payment_method_configurations/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/payment_method_configurations/retrieve.md
        case retrieve(id: Stripe.PaymentMethodConfigurations.Configuration.ID)
        // https://docs.stripe.com/api/payment_method_configurations/update.md
        case update(
            id: Stripe.PaymentMethodConfigurations.Configuration.ID,
            request: Update.Request
        )
        // https://docs.stripe.com/api/payment_method_configurations/list.md
        case list(request: List.Request)
    }
}

extension Stripe.PaymentMethodConfigurations.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.PaymentMethodConfigurations.API> {
            OneOf {
                Route(.case(Stripe.PaymentMethodConfigurations.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.paymentMethodConfigurations
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentMethodConfigurations.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                Route(.case(Stripe.PaymentMethodConfigurations.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.paymentMethodConfigurations
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.PaymentMethodConfigurations.Configuration.ID.self
                            )
                        )
                    }
                }

                Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.PaymentMethodConfigurations.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.paymentMethodConfigurations
                    Path {
                        Parse(
                            .string.representing(
                                Stripe.PaymentMethodConfigurations.Configuration.ID.self
                            )
                        )
                    }
                    URLRouting.Body(
                        .form(
                            Stripe.PaymentMethodConfigurations.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // TODO: Fix list route query parameter parsing
                // URLRouting currently doesn't support array parameters in queries properly
                // Route(.case(Stripe.PaymentMethodConfigurations.API.list)) {
                //     Method.get
                //     Path.v1
                //     Path.paymentMethodConfigurations
                //     Parse(.memberwise(Stripe.PaymentMethodConfigurations.List.Request.init, { ($0.application, $0.endingBefore, $0.limit, $0.startingAfter) })) {
                //         Query {
                //             Optionally {
                //                 Field("application") { Parse(.string) }
                //             }
                //             Optionally {
                //                 Field("ending_before") { Parse(.string) }
                //             }
                //             Optionally {
                //                 Field("limit") { Int.parser() }
                //             }
                //             Optionally {
                //                 Field("starting_after") { Parse(.string) }
                //             }
                //         }
                //     }
                // }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var paymentMethodConfigurations: Path<PathBuilder.Component<String>> { Path {
        "payment_method_configurations"
    } }
}
