import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLRouting

extension Stripe.Terminal.Locations {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/terminal/locations/create.md
        case create(request: Create.Request)
        // https://docs.stripe.com/api/terminal/locations/retrieve.md
        case retrieve(id: Location.ID)
        // https://docs.stripe.com/api/terminal/locations/update.md
        case update(id: Location.ID, request: Update.Request)
        // https://docs.stripe.com/api/terminal/locations/list.md
        case list(request: List.Request)
        // https://docs.stripe.com/api/terminal/locations/delete.md
        case delete(id: Location.ID)
    }
}

extension Stripe.Terminal.Locations.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Terminal.Locations.API> {
            OneOf {
                URLRouting.Route(.case(Stripe.Terminal.Locations.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.locations
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Locations.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Terminal.Locations.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.terminal
                    Path.locations
                    Path { Parse(.string.representing(Stripe.Terminal.Locations.Location.ID.self)) }
                }

                URLRouting.Route(.convert(
                        apply: { (id: $0.0, request: $0.1) },
                        unapply: { ($0.id, $0.request) }
                    )
                    .map(.case(Stripe.Terminal.Locations.API.cases.update))) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.locations
                    Path { Parse(.string.representing(Stripe.Terminal.Locations.Location.ID.self)) }
                    URLRouting.Body(
                        .form(
                            Stripe.Terminal.Locations.Update.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                // TODO: Fix list route query parameter parsing
                // URLRouting.Route(.case(Stripe.Terminal.Locations.API.list)) {
                //     Method.get
                //     Path.v1
                //     Path.terminal
                //     Path.locations
                // }

                URLRouting.Route(.case(Stripe.Terminal.Locations.API.cases.delete)) {
                    Method.delete
                    Path.v1
                    Path.terminal
                    Path.locations
                    Path { Parse(.string.representing(Stripe.Terminal.Locations.Location.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var locations: Path<PathBuilder.Component<String>> { Path {
        "locations"
    } }
}
