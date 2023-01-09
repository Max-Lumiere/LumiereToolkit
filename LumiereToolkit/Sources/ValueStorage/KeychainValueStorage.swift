import Foundation

public final class KeychainValueStorage<Value: Codable>: ValueStorage {
    private let query: [String: Any]

    public init(key: String, secClass: CFString = kSecClassGenericPassword) {
        query = [kSecClass as String: secClass,
                 kSecAttrLabel as String: key,
                 kSecAttrService as String: "com.max-lumiere.toolkit.value_storage"]
    }

    public func write(_ value: Value?) {
        var query: [String: Any] = self.query

        SecItemDelete(query as CFDictionary)
        guard let data = try? PropertyListEncoder().encode([value]) else { return }

        query[kSecValueData as String] = data as CFData
        SecItemAdd(query as CFDictionary, nil)
    }

    public func read() -> Value? {
        var query = self.query

        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = true
        var result: AnyObject?

        SecItemCopyMatching(query as CFDictionary, &result)
        return (result as? Data).flatMap { try? PropertyListDecoder().decode(Array<Value>.self, from: $0).first }
    }
}
