
import UIKit

public extension NibBased where Self: UIViewController {

    static func instantiateFromNib() -> Self { Self.init(nibName: nibName, bundle: bundle) }
}
