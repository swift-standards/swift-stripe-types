import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting
import URLRouting

extension Stripe.Terminal.Locations {
    @CasePathable
    @dynamicMemberLookup
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
                URLRouting.Route(.case(Stripe.Terminal.Locations.API.create)) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.locations
                    Body(
                        .form(
                            Stripe.Terminal.Locations.Create.Request.self,
                            decoder: .stripe,
                            encoder: .stripe
                        )
                    )
                }

                URLRouting.Route(.case(Stripe.Terminal.Locations.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.terminal
                    Path.locations
                    Path { Parse(.string.representing(Stripe.Terminal.Locations.Location.ID.self)) }
                }

                URLRouting.Route(.case(Stripe.Terminal.Locations.API.update)) {
                    Method.post
                    Path.v1
                    Path.terminal
                    Path.locations
                    Path { Parse(.string.representing(Stripe.Terminal.Locations.Location.ID.self)) }
                    Body(
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

                URLRouting.Route(.case(Stripe.Terminal.Locations.API.delete)) {
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
