
public struct KVCBuilder<Result> {
    private var result: Result

    public init(_ result: Result) {
        self.result = result
    }

    public func with<Value>(value: Value, for keyPath: WritableKeyPath<Result, Value>) -> Self {
        var builder = self

        builder.result[keyPath: keyPath] = value
        return builder
    }

    public func build() -> Result { result }
}
