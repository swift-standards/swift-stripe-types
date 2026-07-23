import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Billing.Alerts {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/billing/alert/create.md
        case create(request: Create.Request)

        // https://docs.stripe.com/api/billing/alert/retrieve.md
        case retrieve(id: Alert.ID)

        // https://docs.stripe.com/api/billing/alert/list.md
        case list(request: List.Request)

        // https://docs.stripe.com/api/billing/alert/activate.md
        case activate(id: Alert.ID)

        // https://docs.stripe.com/api/billing/alert/archive.md
        case archive(id: Alert.ID)

        // https://docs.stripe.com/api/billing/alert/deactivate.md
        case deactivate(id: Alert.ID)
    }
}

extension Stripe.Billing.Alerts.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Billing.Alerts.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    URLRouting.Body(
                        .form(
                            Stripe.Billing.Alerts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.alerts
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Billing.Alerts.List.Request.init,
                                { ($0.alertType, $0.endingBefore, $0.limit, $0.meter, $0.startingAfter) }
                            )
                        )
                    ) {
                        Query {
                            Optionally {
                                Field("alert_type") {
                                    Parse(
                                        .string.representing(
                                            Stripe.Billing.Alerts.Alert.AlertType.self
                                        )
                                    )
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("meter") { Parse(.string) }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.activate)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                    Path.activate
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.archive)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                    Path.archive
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.cases.deactivate)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                    Path.deactivate
                }
            }
        }
    }
}

// MARK: - Path Extensions
extension Path<PathBuilder.Component<String>> {
    public static var alerts: Path<PathBuilder.Component<String>> { Path {
        "alerts"
    } }

    public static var activate: Path<PathBuilder.Component<String>> { Path {
        "activate"
    } }

    public static var archive: Path<PathBuilder.Component<String>> { Path {
        "archive"
    } }
}
