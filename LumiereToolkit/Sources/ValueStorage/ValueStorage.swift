import Foundation

public protocol ValueStorage {
    associatedtype Value: Codable

    func write(_ value: Value?)
    func read() -> Value?
}

public final class AnyValueStorage<V: Codable>: ValueStorage {
    private let writeClosure: (V?) -> Void
    private let readClosure: () -> V?

    public init<S: ValueStorage>(_ inner: S) where S.Value == V {
        writeClosure = inner.write(_:)
        readClosure = inner.read
    }

    public func write(_ value: V?) { writeClosure(value) }
    public func read() -> V? { readClosure() }
}
