import UIKit

public final class SELayoutConstraint: NSLayoutConstraint {
    @IBInspectable public var specificConstant: CGFloat = 0 {
        didSet {
            constant = UIDevice.current.isSmallScreen ? specificConstant : constant
        }
    }
}
