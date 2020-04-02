
public struct Prism<Whole, Part> {
    public let tryGet: (Whole) -> Part?
    public let inject: (Part) -> Whole

    public init(tryGet: @escaping (Whole) -> Part?, inject: @escaping (Part) -> Whole) {
        self.tryGet = tryGet
        self.inject = inject
    }
}
