//
//  Tagged+RawRepresentable.swift
//  swift-stripe-types
//
// TRANSITIONAL — compatibility shim, part of the coenttb -> institute port.
//
// swift-tagged-primitives' `Tagged<Tag, Underlying>` deliberately does NOT
// conform to `RawRepresentable` (it predates noncopyable generics; see
// swift-tagged-primitives' "Tagged Primitives.docc"). This package's ~300
// `Parse(.string.representing(Model.ID.self))` router call sites (from
// pointfreeco/swift-parsing's `Conversion.representing(_:)`) and the few
// direct `.rawValue` accesses (e.g. PaymentSource.id) require
// `RawRepresentable` conformance on the ID type.
//
// This extension bridges the two so the existing call sites keep compiling
// and behaving the same, without redesigning them. Scoped to Copyable &
// Escapable Underlying, matching how every Tagged ID in this package is
// used (String-backed resource identifiers).
//
// `Tagged`'s `Codable` conformance now round-trips as the bare underlying
// value (hand-written `singleValueContainer` conformance in
// swift-tagged-primitives), matching the wire format Stripe's JSON API
// expects — no shim needed there. This extension is scoped to
// `RawRepresentable` alone, which swift-tagged-primitives still does not
// provide (see above), for the `.representing(_:)` router call sites and
// direct `.rawValue` accesses.
import Tagged_Primitives

extension Tagged: RawRepresentable
where Tag: ~Copyable & ~Escapable, Underlying: Copyable & Escapable {
    public typealias RawValue = Underlying

    public init?(rawValue: Underlying) {
        self.init(rawValue)
    }

    public var rawValue: Underlying {
        self.underlying
    }
}
