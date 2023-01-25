//
//  Created by Maksim Sviatlou on 25.01.23.

import UIKit
import Combine

public extension UINavigationController {

    private final class EmptyGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate { }

    func setUpSwipeBackSupport(delegate: UIGestureRecognizerDelegate? = nil) -> AnyCancellable {
        let previousDelegate = interactivePopGestureRecognizer?.delegate
        let previousEnablance = interactivePopGestureRecognizer?.isEnabled ?? false
        var emptyDelegate: EmptyGestureRecognizerDelegate?

        if let delegate = delegate {

            interactivePopGestureRecognizer?.delegate = delegate
        } else {
            emptyDelegate = EmptyGestureRecognizerDelegate()
            interactivePopGestureRecognizer?.delegate = emptyDelegate
        }

        interactivePopGestureRecognizer?.isEnabled = true

        return AnyCancellable { [weak self, weak previousDelegate] in
            emptyDelegate = nil
            self?.interactivePopGestureRecognizer?.delegate = previousDelegate
            self?.interactivePopGestureRecognizer?.isEnabled = previousEnablance
        }
    }
}
