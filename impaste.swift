// pbimg - Save image data from the macOS clipboard to a file.
// 
// Copyright (c) 2024 Paul Smith <paulsmith@pobox.com>
// Licensed under the The "MIT No Attribution" (MIT-0) License
// See COPYING for more information.

import Foundation
import AppKit

func errorAndDie(_ message: String) {
    fputs("\u{1B}[31mError: \(message)\u{1B}[0m\n", stderr)
    exit(1)
}

func processClipboardImage(_ filePath: String?) {
    let pasteboard = NSPasteboard.general
    guard let data = pasteboard.data(forType: .tiff) ?? pasteboard.data(forType: .png) else {
        errorAndDie("No image data found in the clipboard.")
        return
    }

    if let filePath = filePath {
        do {
            try data.write(to: URL(fileURLWithPath: filePath))
            print("Image data saved to: \(filePath)")
        } catch {
            errorAndDie("Failed to save image data to: \(filePath)")
        }
    } else {
        FileHandle.standardOutput.write(data)
    }
}

let arguments = CommandLine.arguments
let forceOutput = arguments.contains("-f") || arguments.contains("--force")

func printUsage() {
    print("Usage:")
    print("\t\(CommandLine.arguments[0]) <file_path>")
    print("or")
    print("\t\(CommandLine.arguments[0]) > <file_path>")
    print("")
    print("Options:")
    print("\t-f, --force\tForce output of raw image bytes to stdout even if a file path is provided.")
    exit(1)
}

if arguments.count == 2 && !forceOutput {
    let filePath = arguments[1]
    processClipboardImage(filePath)
} else if isatty(STDOUT_FILENO) == 0 || forceOutput {
    processClipboardImage(nil)
} else {
    printUsage()
}
