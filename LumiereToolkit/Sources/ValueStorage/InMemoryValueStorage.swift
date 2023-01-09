import Foundation

public final class InMemoryValueStorage<Value: Codable>: ValueStorage {
    private let lock = NSLock()
    private var value: Value?

    public init(value: Value? = nil) {
        self.value = value
    }

    public func write(_ value: Value?) {
        lock.lock()
        defer { lock.unlock() }
        self.value = value
    }

    public func read() -> Value? {
        lock.lock()
        defer { lock.unlock() }
        return value
    }
}
