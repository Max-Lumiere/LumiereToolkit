
import UIKit

let keyboardAnimation = "KeyboardAnimation"

final class AnimatedKeyboardConstraint: KeyboardConstraint {

    override func updateConstant(for notification: Notification) {
        guard let info = notification.userInfo else { return }
        let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0

        UIView.beginAnimations(keyboardAnimation, context: nil)
        UIView.setAnimationDuration(animationDuration)

        if let animationCurve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve {
            UIView.setAnimationCurve(animationCurve)
        }

        super.updateConstant(for: notification)
        UIView.commitAnimations()
    }
}
