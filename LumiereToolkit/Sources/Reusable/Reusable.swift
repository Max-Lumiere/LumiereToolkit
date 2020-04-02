
public protocol Reusable {

    var reuseIdentifier: String? { get }
    static var reuseIdentifier: String { get }
}

public extension Reusable {

    var reuseIdentifier: String? { Self.reuseIdentifier }
    static var reuseIdentifier: String { "\(Self.self)" }
}
