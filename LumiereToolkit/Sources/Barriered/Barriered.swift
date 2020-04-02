
public final class Barriered<Value> {
    private let queue = DispatchQueue(label: "com.LumiereToolkit.Barriered", attributes: .concurrent)
    private var _value: Value

    public init(_ value: Value) {
        self._value = value
    }

    public var value: Value {
        get { queue.sync { _value } }
        set { queue.async(flags: .barrier) { [weak self] in self?._value = newValue } }
    }
}
