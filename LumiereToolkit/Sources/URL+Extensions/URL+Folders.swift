import Foundation

public extension URL {
    static var cache: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    func getQueryStringParameter(param: String) -> String? {
        if let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems {
            return queryItems.first(where: { $0.name == param })?.value
        }
        return nil
    }
}
