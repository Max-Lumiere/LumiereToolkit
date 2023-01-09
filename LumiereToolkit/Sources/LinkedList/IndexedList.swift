import Foundation

public struct IndexedList<Key: Hashable, Value> {
    public typealias Pair = (key: Key, value: Value)
    private var list = List<Pair>()
    private var indexes = [Key: List<Pair>.Node]()

    public init() { }

    public mutating func add(_ key: Key, value: Value) {
        indexes[key] = list.append((key, value))
    }

    public mutating func remove(_ key: Key) {
        guard let node = indexes.removeValue(forKey: key) else { return }
        list.remove(node)
    }

    public mutating func removeAll() {
        list = .init()
        indexes = .init()
    }

    public func contains(_ key: Key) -> Bool {
        indexes[key] != nil
    }

    public func toArray() -> [Pair] {
        Array(list)
    }

    public subscript(key: Key) -> Value? {
        get {
            indexes[key]?.value.value
        }
        set(newValue) {
            if let newValue = newValue {
                add(key, value: newValue)
            } else {
                remove(key)
            }
        }
    }
}

extension IndexedList: Sequence {
    public func makeIterator() -> AnyIterator<Pair> {
        list.makeIterator()
    }
}
