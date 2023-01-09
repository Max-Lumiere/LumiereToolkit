import UIKit

public final class XFamilyLayoutConstraint: NSLayoutConstraint {
    @IBInspectable public var specificConstant: CGFloat = 0 {
        didSet {
            constant = UIDevice.current.isXFamily ? specificConstant : constant
        }
    }
}
