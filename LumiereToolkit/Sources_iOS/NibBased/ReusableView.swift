import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: NibBased {
    static var reuseIdentifier: String { nibName }
}

public extension UIView {
    func addToView(_ otherView: UIView) {
        otherView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: otherView.topAnchor, constant: 0).isActive = true
        self.leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: 0).isActive = true
    }
}

public extension UITableView {

    func cell<T: UITableViewCell>(at indexPath: IndexPath) -> T? where T: ReusableView {
        cellForRow(at: indexPath) as? T
    }

    func register(_ type: (NibBased & ReusableView).Type) {
        register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        if let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Wrong type of cell for asked \(type)")
    }
}

public extension UICollectionView {

    func cell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T? where T: ReusableView {
        cellForItem(at: indexPath) as? T
    }

    func register<T: ReusableView>(_ type: T.Type) where T: NibBased {
        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func register<T: ReusableView>(_ type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type,
                                                      for indexPath: IndexPath) -> T where T: ReusableView {
        if let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Wrong type of cell for asked \(type)")
    }
}
