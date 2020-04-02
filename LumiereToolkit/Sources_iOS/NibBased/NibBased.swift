
import UIKit

protocol NibBased: AnyObject {

    static var nibName: String { get }
    static var nib: UINib { get }
    static var bundle: Bundle { get }
}

extension NibBased {

    static var nibName: String { "\(self)"}
    static var nib: UINib { UINib(nibName: nibName, bundle: bundle) }
    static var bundle: Bundle { Bundle(for: Self.self) }
}
