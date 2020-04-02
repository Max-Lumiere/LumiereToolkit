
public struct Creator<Argument, Type> {
    private let creation: (Argument) -> Type

    public init(_ creation: @escaping (Argument) -> Type) {
        self.creation = creation
    }

    public func create(with argument: Argument) -> Type {
        creation(argument)
    }
}

public struct ThrowingCreator<Argument, Type> {
    private let creation: (Argument) throws -> Type

    public init(_ creation: @escaping (Argument) throws -> Type) {
        self.creation = creation
    }

    public func create(with argument: Argument) throws -> Type {
        try creation(argument)
    }
}

public extension Creator where Argument == Void {

    func create() -> Type {
        create(with: ())
    }
}

public extension ThrowingCreator where Argument == Void {

    func create() throws -> Type {
        try create(with: ())
    }
}
