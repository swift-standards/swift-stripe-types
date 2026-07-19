//
//  StripeExpandable.swift
//
//
//  Created by Andrew Edwards on 4/11/20.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode<U>(
        _ type: ExpandableCollection<U>.Type,
        forKey key: Self.Key
    ) throws -> ExpandableCollection<U> where U: Codable {
        return try decodeIfPresent(type, forKey: key) ?? ExpandableCollection<U>()
    }

    public func decode<U, ID>(
        _ type: Expandable<U, ID>.Type,
        forKey key: Self.Key
    ) throws -> Expandable<U, ID> where U: Codable {
        return try decodeIfPresent(type, forKey: key) ?? Expandable<U, ID>()
    }

    public func decode<U, D>(
        _ type: DynamicExpandable<U, D>.Type,
        forKey key: Self.Key
    ) throws -> DynamicExpandable<U, D> where U: Codable, D: Codable {
        return try decodeIfPresent(type, forKey: key) ?? DynamicExpandable<U, D>()
    }
}

public typealias ExpandableOf<Model: Codable> = Expandable<Model, Model.ID>
where Model: Identifiable, Model.ID: Codable & Hashable & Sendable

@propertyWrapper
public struct Expandable<Model: Codable, ID: Codable & Hashable & Sendable>: Codable {

    enum ExpandableState {
        case unexpanded(ID)
        indirect case expanded(Model)
        case empty
    }

    public init(
        model: Model
    ) {
        self._state = .expanded(model)
    }

    public init(
        id: ID?
    ) {
        if let id {
            self._state = .unexpanded(id)
        } else {
            self._state = .empty
        }
    }

    public init(
        id: String?
    ) where ID == String {
        if let id {
            self._state = .unexpanded(id)
        } else {
            self._state = .empty
        }
    }

    public init(
        id: ID?
    ) where Model: Identifiable, ID == Model.ID {
        if let id {
            self._state = .unexpanded(id)
        } else {
            self._state = .empty
        }
    }

    public init() {
        self._state = .empty
    }

    public init(
        from decoder: Decoder
    ) throws {
        if let container = try decoder.singleValueContainerIfPresentAndNotNull() {
            do {
                self._state = .unexpanded(try container.decode(ID.self))
            } catch is DecodingError {
                // `ID` may be a wrapper type (e.g. `Tagged<Tag, String>`) whose own
                // `init(from:)` reports the typeMismatch against its *underlying*
                // wire type, not `ID.self` — so a guard comparing the thrown type's
                // identity to `ID.self` never matches and the error propagates
                // uncaught. Fall back structurally: any decoding failure while
                // reading `ID` means the payload was the expanded `Model` instead.
                self._state = .expanded(try container.decode(Model.self))
            }
        } else {
            self._state = .empty
        }
    }

    private var _state: ExpandableState

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch _state {
        case .unexpanded(let id):
            try container.encode(id)
        case .expanded(let model):
            try container.encode(model)
        default:
            try container.encodeNil()
        }
    }

    public var wrappedValue: ID? {
        switch _state {
        case .unexpanded(let id):
            return id
        case .expanded, .empty:
            return nil
        }
    }

    public var projectedValue: Model? {
        switch _state {
        case .unexpanded, .empty:
            return nil
        case .expanded(let model):
            return model
        }
    }
}

extension Expandable: Equatable where Model: Equatable {}
extension Expandable: Hashable where Model: Hashable {}
extension Expandable: Sendable where Model: Sendable {}

extension Expandable.ExpandableState: Equatable where Model: Equatable {}
extension Expandable.ExpandableState: Hashable where Model: Hashable {}
extension Expandable.ExpandableState: Sendable where Model: Sendable {}

@propertyWrapper
public struct DynamicExpandable<A: Codable & Hashable & Sendable, B: Codable & Hashable & Sendable>:
    Codable & Hashable & Sendable
{
    enum ExpandableState: Codable, Hashable, Sendable {
        case unexpanded(String)
        indirect case expanded(Either)
        case empty

        // Custom hash implementation
        func hash(into hasher: inout Hasher) {
            switch self {
            case .unexpanded(let id):
                hasher.combine(0)  // Discriminator for unexpanded
                hasher.combine(id)
            case .expanded(let either):
                hasher.combine(1)  // Discriminator for expanded
                hasher.combine(either)
            case .empty:
                hasher.combine(2)  // Discriminator for empty
            }
        }

        // Custom equality implementation
        static func == (lhs: ExpandableState, rhs: ExpandableState) -> Bool {
            switch (lhs, rhs) {
            case (.unexpanded(let l), .unexpanded(let r)):
                return l == r
            case (.expanded(let l), .expanded(let r)):
                return l == r
            case (.empty, .empty):
                return true
            default:
                return false
            }
        }

        // Helper enum to store either A or B
        enum Either: Hashable, Codable {
            case left(A)
            case right(B)

            // Implement Codable
            public init(
                from decoder: Decoder
            ) throws {
                let container = try decoder.singleValueContainer()
                do {
                    self = .left(try container.decode(A.self))
                } catch {
                    self = .right(try container.decode(B.self))
                }
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .left(let a):
                    try container.encode(a)
                case .right(let b):
                    try container.encode(b)
                }
            }
        }
    }

    public init(
        model: A
    ) {
        self._state = .expanded(.left(model))
    }

    public init(
        model: B
    ) {
        self._state = .expanded(.right(model))
    }

    public init(
        id: String?
    ) {
        if let id {
            self._state = .unexpanded(id)
        } else {
            self._state = .empty
        }
    }

    public init() {
        self._state = .empty
    }

    public init(
        from decoder: Decoder
    ) throws {
        let codingPath = decoder.codingPath
        do {
            let container = try decoder.singleValueContainer()
            do {
                if container.decodeNil() {
                    _state = .empty
                } else {
                    _state = .unexpanded(try container.decode(String.self))
                }
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                do {
                    _state = .expanded(.left(try container.decode(A.self)))
                } catch {
                    _state = .expanded(.right(try container.decode(B.self)))
                }
            }
        } catch DecodingError.keyNotFound(_, let context)
            where context.codingPath.count == codingPath.count
        {
            _state = .empty
        }
    }
    private var _state: ExpandableState

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch _state {
        case .unexpanded(let id):
            try container.encode(id)
        case .expanded(let either):
            switch either {
            case .left(let a):
                try container.encode(a)
            case .right(let b):
                try container.encode(b)
            }
        case .empty:
            try container.encodeNil()
        }
    }

    public var wrappedValue: String? {
        switch _state {
        case .unexpanded(let id):
            return id
        case .expanded, .empty:
            return nil
        }
    }

    public var projectedValue: DynamicExpandable<A, B> { self }

    public func callAsFunction<T: Codable>(as type: T.Type) -> T? {
        switch _state {
        case .unexpanded, .empty:
            return nil
        case .expanded(let either):
            switch either {
            case .left(let a):
                return a as? T
            case .right(let b):
                return b as? T
            }
        }
    }

}

@propertyWrapper
public struct ExpandableCollection<Model: Codable>: Codable {
    enum ExpandableState {
        case unexpanded([String])
        indirect case expanded([Model])
        case empty
    }

    public init() {
        self._state = .empty
    }

    public init(
        ids: [String]?
    ) {
        if let ids {
            self._state = .unexpanded(ids)
        } else {
            self._state = .empty
        }
    }

    public init(
        models: [Model]?
    ) {
        if let models {
            self._state = .expanded(models)
        } else {
            self._state = .empty
        }
    }

    public init(
        from decoder: Decoder
    ) throws {
        if let container = try decoder.singleValueContainerIfPresentAndNotNull() {
            do {
                self._state = .unexpanded(try container.decode([String].self))
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                self._state = .expanded(try container.decode([Model].self))
            }
        } else {
            self._state = .empty
        }
    }

    private var _state: ExpandableState

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch _state {
        case .unexpanded(let ids):
            try container.encode(ids)
        case .expanded(let models):
            try container.encode(models)
        default:
            try container.encodeNil()
        }
    }

    public var wrappedValue: [String]? {
        switch _state {
        case .unexpanded(let ids):
            return ids
        case .expanded, .empty:
            return nil
        }
    }

    public var projectedValue: [Model]? {
        switch _state {
        case .unexpanded, .empty:
            return nil
        case .expanded(let models):
            return models
        }
    }
}

extension ExpandableCollection: Equatable where Model: Equatable {}
extension ExpandableCollection: Hashable where Model: Hashable {}
extension ExpandableCollection: Sendable where Model: Sendable {}

extension ExpandableCollection.ExpandableState: Equatable where Model: Equatable {}
extension ExpandableCollection.ExpandableState: Hashable where Model: Hashable {}
extension ExpandableCollection.ExpandableState: Sendable where Model: Sendable {}

extension Decoder {
    func singleValueContainerIfPresentAndNotNull() throws -> SingleValueDecodingContainer? {
        do {
            let container = try self.singleValueContainer()

            if container.decodeNil() {
                return nil
            }
            return container
        } catch DecodingError.keyNotFound(_, let context)
            where context.codingPath.count == self.codingPath.count
        {
            return nil
        }
    }
}
