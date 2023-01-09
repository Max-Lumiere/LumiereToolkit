import Combine

extension NSKeyValueObservation: Cancellable {

    public func cancel() {
        invalidate()
    }
}
