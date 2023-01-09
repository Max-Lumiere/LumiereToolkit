
import Combine

public final class StubCoordinator<Result>: BaseCoordinator<Result> {
    private let result: Result

    public init(_ result: Result) {
        self.result = result
    }

    override public func start() -> AnyPublisher<Result, Never> {
        Future { [weak self] promise in
            guard let self else { return }

            promise(Swift.Result.success(self.result))
        }.eraseToAnyPublisher()
    }
}
