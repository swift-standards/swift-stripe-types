//
//  Stripe Files Types API.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives
import URLFormCodingURLRouting

extension Stripe.Files {
    @Cases
    public enum API: Equatable, Sendable {
        // https://docs.stripe.com/api/files/create.md
        case create(request: Stripe.Files.Create.Request)
        // https://docs.stripe.com/api/files/retrieve.md
        case retrieve(id: Stripe.Files.File.ID)
        // https://docs.stripe.com/api/files/list.md
        case list(request: Stripe.Files.List.Request)
    }
}

extension Stripe.Files.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Stripe.Files.API> {
            OneOf {
                // https://docs.stripe.com/api/files/create.md
                URLRouting.Route(.case(Stripe.Files.API.cases.create)) {
                    Method.post
                    Path.v1
                    Path.files
                    // File upload requires multipart/form-data, not handled by URLRouting
                    URLRouting.Body(
                        .form(Stripe.Files.Create.Request.self, decoder: .stripe, encoder: .stripe)
                    )
                }

                // https://docs.stripe.com/api/files/retrieve.md
                URLRouting.Route(.case(Stripe.Files.API.cases.retrieve)) {
                    Method.get
                    Path.v1
                    Path.files
                    Path { Parse(.string.representing(Stripe.Files.File.ID.self)) }
                }

                // https://docs.stripe.com/api/files/list.md
                URLRouting.Route(.case(Stripe.Files.API.cases.list)) {
                    Method.get
                    Path.v1
                    Path.files
                    Parse(
                        .convert(
                            apply: { ($0.0.0.0.0, $0.0.0.0.1, $0.0.0.1, $0.0.1, $0.1) },
                            unapply: { (((($0.0, $0.1), $0.2), $0.3), $0.4) }
                        )
                        .map(
                            .memberwise(
                                Stripe.Files.List.Request.init,
                                { ($0.created, $0.endingBefore, $0.limit, $0.purpose, $0.startingAfter) }
                            )
                        )
                    ) {
                        URLRouting.Query {
                            Optionally {
                                Field("created") {
                                    Parse(.string.representing(Stripe.DateFilter.self))
                                }
                            }
                            Optionally {
                                Field("ending_before") { Parse(.string) }
                            }
                            Optionally {
                                Field("limit") { Int.parser() }
                            }
                            Optionally {
                                Field("purpose") {
                                    Parse(.string.representing(Stripe.Files.File.Purpose.self))
                                }
                            }
                            Optionally {
                                Field("starting_after") { Parse(.string) }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static var files: Path<PathBuilder.Component<String>> { Path {
        "files"
    } }
}
