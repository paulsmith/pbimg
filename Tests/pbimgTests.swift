import XCTest
@testable import pbimg

class MockPasteboard: PasteboardHandling {
    var data: Data?
    var type: NSPasteboard.PasteboardType?

    func data(forType: NSPasteboard.PasteboardType) -> Data? {
        if type == forType {
            return data
        }
        return nil
    }
}

class MockFileSystemHandler: FileSystemHandling {
    var writtenData: Data?
    var writtenPath: String?
    var writeError: Error?

    func write(_ data: Data, toPath path: String) throws {
        writtenData = data
        writtenPath = path

        if let error = writeError {
            throw error
        }
    }
}

class PbimgTests: XCTestCase {
    func testProcessClipboardImageWithPngData() {
        let smallestPng = "R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
        let pasteboard = MockPasteboard()
        let fileSystem = MockFileSystemHandler()
        let pngData = Data(base64Encoded: smallestPng)
        pasteboard.data = pngData
        pasteboard.type = .png

        processClipboardImage("paste.png", pasteboard: pasteboard, fileSystem: fileSystem)

        XCTAssertEqual(fileSystem.writtenData, Data(base64Encoded: smallestPng))
        let writtenFilename = URL(fileURLWithPath: fileSystem.writtenPath!).lastPathComponent
        XCTAssertEqual(writtenFilename, "paste.png")
    }
}
