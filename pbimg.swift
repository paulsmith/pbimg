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
    var data: Data?
    var fileExtension = "png"

    if let tiffData = pasteboard.data(forType: .tiff),
       let tiffRep = NSBitmapImageRep(data: tiffData) {
        data = tiffRep.representation(using: .png, properties: [:])
    } else if let pngData = pasteboard.data(forType: .png) {
        data = pngData
    }

    guard let imageData = data else {
        errorAndDie("No image data found in the clipboard.")
        return
    }

    if let filePath = filePath {
        let fileUrl = URL(fileURLWithPath: filePath)
        let pathExtension = fileUrl.pathExtension.lowercased()
        if pathExtension == "tiff" || pathExtension == "tif" {
            fileExtension = "tiff"
        }

        let outputPath = fileUrl.deletingPathExtension().appendingPathExtension(fileExtension).path

        do {
            try imageData.write(to: URL(fileURLWithPath: outputPath))
            print("Image data saved to: \(outputPath)")
        } catch {
            errorAndDie("Failed to save image data to: \(outputPath)")
        }
    } else {
        FileHandle.standardOutput.write(imageData)
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
