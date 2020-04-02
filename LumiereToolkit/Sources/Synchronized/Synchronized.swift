
public final class Synchronized<Value> {
    private let lock = NSLock()
    private var _value: Value

    public init(_ value: Value) {
        self._value = value
    }

    public var value: Value {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _value
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _value = newValue
        }
    }
}
