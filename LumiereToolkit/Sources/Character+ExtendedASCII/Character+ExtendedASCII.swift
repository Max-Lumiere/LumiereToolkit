import Foundation

public extension Character {

    var extendedAsciiValue: UInt8? {
        guard !isASCII else { return asciiValue }
        let cfEncoding = CFStringEncodings.dosLatinUS
        let nsEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let encoding = String.Encoding(rawValue: nsEncoding)

        return "\(self)".data(using: encoding)?.first
    }
}
