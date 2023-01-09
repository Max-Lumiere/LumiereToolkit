
open class KeyboardConstraint: NSLayoutConstraint {
    private var keyboardIsActive = false

    public override init() {
        super.init()
        initialize()
    }

    public override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        let this = super.awakeAfter(using: aDecoder)

        initialize()
        return this
    }

    private func initialize() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardConstraintHandleKeyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardConstraintHandleKeyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardConstraintHandleKeyboardDidHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }

    @objc private dynamic func keyboardConstraintHandleKeyboardDidShow(_ notification: Notification) {
        keyboardIsActive = true
    }

    @objc private dynamic func keyboardConstraintHandleKeyboardDidHide(_ notification: Notification) {
        keyboardIsActive = false
    }

    @objc private dynamic func keyboardConstraintHandleKeyboardWillChangeFrame(_ notification: Notification) {
        updateConstant(for: notification)
    }

    func updateConstant(for notification: Notification) {
        guard let info = notification.userInfo,
              let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              !keyboardIsActive
            else { return }
        let windowHeight = UIScreen.main.bounds.size.height
        let constantValueOnWindow = windowHeight - endFrame.origin.y
        let items: [UIView] = [firstItem, secondItem].compactMap { $0 as? UIView }

        guard let item = items.first else {
            constant = constantValueOnWindow
            return
        }

        if let itemFrameOnWindow = item.superview?.convert(item.frame, to: nil) {
            constant = max(0, itemFrameOnWindow.maxY - endFrame.origin.y)
        } else {
            constant = constantValueOnWindow
        }

        item.superview?.layoutIfNeeded()
    }
}
