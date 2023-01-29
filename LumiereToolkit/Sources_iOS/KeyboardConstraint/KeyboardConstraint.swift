
open class KeyboardConstraint: NSLayoutConstraint {
    private lazy var initialConstant = constant

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
    }

    @objc private dynamic func keyboardConstraintHandleKeyboardWillChangeFrame(_ notification: Notification) {
        updateConstant(for: notification)
    }

    private func updateConstant(for notification: Notification) {
        guard let info = notification.userInfo,
              let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        let windowHeight = UIScreen.main.bounds.size.height
        var constantValueOnWindow = windowHeight - endFrame.origin.y
        let items: [UIView] = [firstItem, secondItem].compactMap { $0 as? UIView }

        guard let item = items.first else {
            constant = constantValueOnWindow
            return
        }

        constantValueOnWindow = windowHeight - endFrame.origin.y - initialConstant
        constant = constantValueOnWindow
        item.superview?.layoutIfNeeded()
    }
}
