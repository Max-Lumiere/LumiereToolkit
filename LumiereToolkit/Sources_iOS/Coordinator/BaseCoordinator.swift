import Foundation
import Combine

public protocol ResponderChain: AnyObject {
    func responderForLink(_ code: String) -> DeepLinkResponder?
}

extension BaseCoordinator: ResponderChain {
    public func removeYoungerSiblings(of child: DeepLinkResponder) {
        for (key, sibling) in childCoordinators.toArray().reversed() where sibling.isSelfSustained {
            if sibling === child {
                return
            }
            childCoordinators.remove(key)
        }
    }

    public func childResponder(_ code: String) -> DeepLinkResponder? {
        for (_, coordinator) in childCoordinators.reversed() {
            if let responder = coordinator.responderForLink(code) {
                return responder
            }
        }
        return nil
    }

    public func responderForLink(_ code: String) -> DeepLinkResponder? {
        if canHandleLink(code) {
            return self
        }
        return childResponder(code)
    }
}

open class BaseCoordinator<ResultType>: Identifiable, DeepLinkResponder {
    public let id = UUID()
    open var additionalCheck: (AnyObject) -> Void = { _ in }
    private var childCoordinators = IndexedList<UUID, DeepLinkResponder & ResponderChain>()
    private var cancellables = Set<AnyCancellable>()

    public init() { }

    open var isSelfSustained: Bool { true }

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.id] = coordinator
        coordinator.additionalCheck = additionalCheck
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.id] = nil
        additionalCheck(coordinator)
    }

    open func removeAllChildren() {
        for (key, child) in childCoordinators where child.isSelfSustained {
            additionalCheck(child)
            childCoordinators.remove(key)
        }
    }

    @discardableResult
    open func coordinate<T>(to coordinator: BaseCoordinator<T>, onStart: () -> Void = {}) -> AnyPublisher<T, Never> {
        guard isSelfSustained else { return Empty().eraseToAnyPublisher() }
        store(coordinator: coordinator)

        let publisher = coordinator.start().first()

        publisher.sink { [weak self, weak coordinator] _ in
            guard let coordinator = coordinator else { return }

            self?.free(coordinator: coordinator)

        }.store(in: &cancellables)

        onStart()
        return publisher.eraseToAnyPublisher()
    }

    open func start() -> AnyPublisher<ResultType, Never> {
        fatalError("Start method should be implemented.")
    }

    open func canHandleLink(_ code: String) -> Bool {
        false
    }

    open func handleLink(_ code: String) {

    }
}
