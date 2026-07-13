import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import URL_Routing_Form_Coding

extension Stripe.ConfirmationToken {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/confirmation_tokens/retrieve.md
        case retrieve(id: ConfirmationToken.ID)
    }
}

extension Stripe.ConfirmationToken.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.ConfirmationToken.API> {
            OneOf {
                Route(.case(Stripe.ConfirmationToken.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.confirmationTokens
                    Path { Parse(.string.representing(ConfirmationToken.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var confirmationTokens: Path<PathBuilder.Component<String>> { Path {
        "confirmation_tokens"
    } }
}
