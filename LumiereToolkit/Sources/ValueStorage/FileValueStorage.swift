import Foundation

public final class FileValueStorage: ValueStorage {
    private let folder: URL
    private let name: String
    private let fileManager: FileManager

    public init(folder: URL, name: String, fileManager: FileManager = .default) {
        self.folder = folder
        self.name = name
        self.fileManager = fileManager

        var isDirectory: ObjCBool = true
        if !fileManager.fileExists(atPath: folder.path, isDirectory: &isDirectory) {
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
        } else if !isDirectory.boolValue {
            try? fileManager.removeItem(at: folder)
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
        }
    }

    public func write(_ value: URL?) {
        let full = folder.appendingPathComponent(name)

        if fileManager.fileExists(atPath: full.path) {
            try? fileManager.removeItem(at: full)
        }

        if let value = value {
            try? fileManager.copyItem(atPath: value.path, toPath: full.path)
        }
    }

    public func read() -> URL? {
        let full = folder.appendingPathComponent(name)

        if fileManager.fileExists(atPath: full.path) {
            return full
        }
        return nil
    }
}
