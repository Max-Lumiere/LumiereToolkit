
import UIKit

@IBDesignable open class GradientView: UIView {

    @IBInspectable open var startColor: UIColor = .blue {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var endColor: UIColor = .green {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var location: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var startPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var endPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var endPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    override open class var layerClass: AnyClass { CAGradientLayer.self }

    open override func layoutSubviews() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }

        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        if location == 0.0 {
            gradientLayer.locations = [0.0, 1.0]
        } else {
            gradientLayer.locations = [0.0, NSNumber(value: Float(location)), 1.0]
        }
    }
}

