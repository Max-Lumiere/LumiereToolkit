import Foundation

public enum UIKitLocalized {
    private static let bundle = Bundle(identifier: "com.apple.UIKit")

    public static var ok: String { stringForKey("OK") }
    public static var search: String { stringForKey("Search") }
    public static var cancel: String { stringForKey("Cancel") }
    public static var done: String { stringForKey("Done") }

    private static func stringForKey(_ key: String) -> String {
        bundle?.localizedString(forKey: key, value: key, table: nil) ?? key
    }
}
