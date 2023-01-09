import Foundation

enum UIKitLocalized {
    private static let bundle = Bundle(identifier: "com.apple.UIKit")

    static var ok: String { stringForKey("OK") }
    static var search: String { stringForKey("Search") }
    static var cancel: String { stringForKey("Cancel") }
    static var done: String { stringForKey("Done") }

    private static func stringForKey(_ key: String) -> String {
        bundle?.localizedString(forKey: key, value: key, table: nil) ?? key
    }
}
