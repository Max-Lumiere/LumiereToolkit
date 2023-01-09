import UIKit

public extension NibBased where Self: UIView {

    static func instantiateFromNib() -> Self {
        if let result = nib.instantiate(withOwner: nil, options: nil).first(where: { $0 is Self }) as? Self {
            return result
        } else {
            fatalError("Attepmted to instantiate view from nib,"
                + " but \(Self.self) wasn't finded in nib named \(nibName)")
        }
    }

    func loadFromNib() { Self.bundle.loadNibNamed(Self.nibName, owner: self, options: nil) }
}
