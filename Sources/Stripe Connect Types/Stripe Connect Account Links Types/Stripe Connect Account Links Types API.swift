import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URLRouting

extension Stripe.Connect.AccountLinks {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/account_links/create.md
        case create(request: Stripe.Connect.AccountLinks.Create.Request)
    }
}

extension Stripe.Connect.AccountLinks.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Connect.AccountLinks.API> {
            OneOf {
                Route(.case(Stripe.Connect.AccountLinks.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.account_links
                    URLRouting.Body(
                        .form(
                            Stripe.Connect.AccountLinks.Create.Request.self,
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
    public static var account_links: Path<PathBuilder.Component<String>> { Path {
        "account_links"
    } }
}
