
import Foundation

public class Observable<T: NSNumber>: NSObject {

    public dynamic var value: T

    public init(_ value: T) {
        self.value = value
    }
}
