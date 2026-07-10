import CasePaths
import Foundation
import Parsing
import Stripe_Types_Models
import Stripe_Types_Shared
import URLFormCodingURLRouting

extension Stripe.Billing.Alerts {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Billing.Alerts.API.create)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Body(
                        .form(
                            Stripe.Billing.Alerts.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.list)) {
                    Method.get
                    Path.v1
                    Path.billing
                    Path.alerts
                    Parse(.memberwise(Stripe.Billing.Alerts.List.Request.init)) {
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
                                Field("limit") { Digits() }
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

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.activate)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                    Path.activate
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.archive)) {
                    Method.post
                    Path.v1
                    Path.billing
                    Path.alerts
                    Path { Parse(.string.representing(Stripe.Billing.Alerts.Alert.ID.self)) }
                    Path.archive
                }

                URLRouting.Route(.case(Stripe.Billing.Alerts.API.deactivate)) {
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
