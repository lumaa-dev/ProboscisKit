//Made by Lumaa

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import UniformTypeIdentifiers

// Dimillian fixed it - https://mastodon.social/@dimillian/111708477095374920

struct ShareableOnlineImage: Codable, Transferable {
    let url: URL
    
    func fetchAsImage() -> Image {
        let data = try? Data(contentsOf: url)
        #if canImport(UIKit)
        guard let data, let uiimage = UIImage(data: data) else {
            return Image(systemName: "photo")
        }
        return Image(uiImage: uiimage)
        #elseif canImport(AppKit)
        guard let data, let nsimage = NSImage(data: data) else {
            return Image(systemName: "photo")
        }
        return Image(nsImage: nsimage)
        #endif
    }
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation { media in
            media.fetchAsImage()
        }
    }
}

#if canImport(UIKit)
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
#elseif canImport(AppKit)
extension NSImage {
    func resized(to size: CGSize) -> NSImage {
        let newImage = NSImage(size: size)
        newImage.lockFocus()
        let context = NSGraphicsContext.current
        context?.imageInterpolation = .high
        self.draw(in: NSRect(origin: .zero, size: size),
                  from: NSRect(origin: .zero, size: self.size),
                  operation: .copy,
                  fraction: 1.0)
        newImage.unlockFocus()
        return newImage
    }
}
#endif

public extension ReceivedTransferredFile {
    var localURL: URL {
        if self.isOriginalFile {
            return file
        }
        let copy = URL.temporaryDirectory.appending(path: "\(UUID().uuidString).\(self.file.pathExtension)")
        try? FileManager.default.copyItem(at: self.file, to: copy)
        return copy
    }
    
}

public extension URL {
    func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: pathExtension)?.preferredMIMEType {
            mimeType
        } else {
            "application/octet-stream"
        }
    }
    
    static let placeholder: URL = URL(string: "https://cdn.pixabay.com/photo/2023/08/28/20/32/flower-8220018_1280.jpg")!
}
