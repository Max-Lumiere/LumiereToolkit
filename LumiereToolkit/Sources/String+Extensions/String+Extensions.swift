import Foundation

public extension String {
    var isLink: Bool {
        guard !isEmpty else { return false }

        if let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue),
           let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) {
            return match.range.length == count
        } else {
            return false
        }
    }

    func filterTagLocalizable() -> String {
        let key = "filter_tag_" + self.lowercased()
        let localized = NSLocalizedString(key, comment: "")
        return localized == key ? self : localized
    }
}
