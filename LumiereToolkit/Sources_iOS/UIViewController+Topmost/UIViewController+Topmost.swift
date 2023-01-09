import UIKit

public extension UIViewController {

    var topmostViewController: UIViewController {
        presentedViewController?.topmostViewController ?? self
    }
}
