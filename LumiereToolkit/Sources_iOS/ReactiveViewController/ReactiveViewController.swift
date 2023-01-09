import UIKit
import Combine

open class ReactiveViewController: UIViewController {

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    public let onViewDidLoad: AnyPublisher<Void, Never>

    private let viewWillAppearSubject = PassthroughSubject<Bool, Never>()
    public let onViewWillAppear: AnyPublisher<Bool, Never>

    private let viewDidAppearSubject = PassthroughSubject<Bool, Never>()
    public let onViewDidAppear: AnyPublisher<Bool, Never>

    private let viewWillDisappearSubject = PassthroughSubject<Bool, Never>()
    public let onViewWillDisappear: AnyPublisher<Bool, Never>

    private let viewDidDisappearSubject = PassthroughSubject<Bool, Never>()
    public let onViewDidDisappear: AnyPublisher<Bool, Never>

    private let memoryWarningSubject = PassthroughSubject<Void, Never>()
    public let onMemoryWarning: AnyPublisher<Void, Never>

    private let viewWillLayoutSubviewsSubject = PassthroughSubject<Void, Never>()
    public let onViewWillLayoutSubviews: AnyPublisher<Void, Never>

    private let viewDidLayoutSubviewsSubject = PassthroughSubject<Void, Never>()
    public let onViewDidLayoutSubviews: AnyPublisher<Void, Never>

    private let isActiveSubject = CurrentValueSubject<Bool, Never>(false)
    public let onIsActive: AnyPublisher<Bool, Never>

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        onViewDidLoad = viewDidLoadSubject.eraseToAnyPublisher()
        onViewWillAppear = viewWillAppearSubject.eraseToAnyPublisher()
        onViewDidAppear = viewDidAppearSubject.eraseToAnyPublisher()
        onViewWillDisappear = viewWillDisappearSubject.eraseToAnyPublisher()
        onViewDidDisappear = viewDidDisappearSubject.eraseToAnyPublisher()
        onMemoryWarning = memoryWarningSubject.eraseToAnyPublisher()
        onViewWillLayoutSubviews = viewWillLayoutSubviewsSubject.eraseToAnyPublisher()
        onViewDidLayoutSubviews = viewDidLayoutSubviewsSubject.eraseToAnyPublisher()
        onIsActive = isActiveSubject.eraseToAnyPublisher()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder: NSCoder) {
        onViewDidLoad = viewDidLoadSubject.eraseToAnyPublisher()
        onViewWillAppear = viewWillAppearSubject.eraseToAnyPublisher()
        onViewDidAppear = viewDidAppearSubject.eraseToAnyPublisher()
        onViewWillDisappear = viewWillDisappearSubject.eraseToAnyPublisher()
        onViewDidDisappear = viewDidDisappearSubject.eraseToAnyPublisher()
        onMemoryWarning = memoryWarningSubject.eraseToAnyPublisher()
        onViewWillLayoutSubviews = viewWillLayoutSubviewsSubject.eraseToAnyPublisher()
        onViewDidLayoutSubviews = viewDidLayoutSubviewsSubject.eraseToAnyPublisher()
        onIsActive = isActiveSubject.eraseToAnyPublisher()
        super.init(coder: coder)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.send(())
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send(animated)
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send(animated)
        isActiveSubject.send(true)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send(animated)
        isActiveSubject.send(false)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearSubject.send(animated)
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewWillLayoutSubviewsSubject.send(())
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsSubject.send(())
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        memoryWarningSubject.send(())
    }
}
