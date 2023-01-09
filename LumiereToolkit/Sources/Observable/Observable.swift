
import Foundation

class Observable<T: NSNumber>: NSObject {

    dynamic var value: T

    init(_ value: T) {
        self.value = value
    }
}
