
import UIKit

public protocol NibBased: AnyObject {

    static var nibName: String { get }
    static var nib: UINib { get }
    static var bundle: Bundle { get }
}

public extension NibBased {

    static var nibName: String { "\(self)"}
    static var nib: UINib { UINib(nibName: nibName, bundle: bundle) }
    static var bundle: Bundle { Bundle(for: Self.self) }
}
