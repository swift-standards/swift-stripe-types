//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Foundation
import URLRouting

extension Path<PathBuilder.Component<String>> {
    package static var v1: Path<PathBuilder.Component<String>> { Path {
        "v1"
    } }

    package static var v2: Path<PathBuilder.Component<String>> { Path {
        "v2"
    } }

    package static var v3: Path<PathBuilder.Component<String>> { Path {
        "v3"
    } }

    package static var v4: Path<PathBuilder.Component<String>> { Path {
        "v4"
    } }

    package static var v5: Path<PathBuilder.Component<String>> { Path {
        "v5"
    } }
}
