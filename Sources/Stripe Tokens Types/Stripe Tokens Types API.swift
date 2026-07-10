//
//  Stripe Tokens Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import CasePaths
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Tokens {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/tokens/create.md
        case create(request: Stripe.Tokens.Create.Request)
        // https://docs.stripe.com/api/tokens/retrieve.md
        case retrieve(id: Stripe.Tokens.Token.ID)
    }
}

extension Stripe.Tokens.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Tokens.API> {
            OneOf {
                // https://docs.stripe.com/api/tokens/create.md
                URLRouting.Route(.case(Stripe.Tokens.API.create)) {
                    Method.post
                    Path.v1
                    Path.tokens
                    Body(
                        .form(Stripe.Tokens.Create.Request.self, decoder: .stripe, encoder: .stripe)
                    )
                }

                // https://docs.stripe.com/api/tokens/retrieve.md
                URLRouting.Route(.case(Stripe.Tokens.API.retrieve)) {
                    Method.get
                    Path.v1
                    Path.tokens
                    Path { Parse(.string.representing(Stripe.Tokens.Token.ID.self)) }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var tokens: Path<PathBuilder.Component<String>> { Path {
        "tokens"
    } }
}
