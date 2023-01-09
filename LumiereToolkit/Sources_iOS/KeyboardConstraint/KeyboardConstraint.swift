
open class KeyboardConstraint: NSLayoutConstraint {
    private var keyboardIsActive = false
    private var previousKeyboardFrame: CGRect = .zero

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
        defer { previousKeyboardFrame = endFrame }
        let windowHeight = UIScreen.main.bounds.size.height
        let window = UIApplication.shared.windows[0]
        var constantValueOnWindow = windowHeight - endFrame.origin.y
        let items: [UIView] = [firstItem, secondItem].compactMap { $0 as? UIView }

        guard let item = items.first else {
            constant = constantValueOnWindow
            return
        }

        let itemFrameOnWindow = window.convert(item.bounds, from: item.coordinateSpace)
        let keyboardIntersection = previousKeyboardFrame.intersection(window.bounds)
        let bottomDistance = windowHeight - (itemFrameOnWindow.maxY + keyboardIntersection.height)

        constantValueOnWindow = windowHeight - endFrame.origin.y - bottomDistance

        constant = constantValueOnWindow
        item.superview?.layoutIfNeeded()
    }
}
