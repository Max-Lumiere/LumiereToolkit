import Foundation

public struct Weak<Reference> {
    public var weakReference: Reference? { provider() }
    private let provider: () -> Reference?

    public init(_ object: Reference) {
        let reference = object as AnyObject

        provider = { [weak reference] in
            reference as? Reference
        }
    }
}
