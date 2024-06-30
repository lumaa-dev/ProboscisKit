// The Swift Programming Language
// https://docs.swift.org/swift-book

public final class ProboscisKit {
    static let author: String = "Lumaa"
    static let contributors: [String] = ["Dimilian"]
    
    public static var appInfo: AppInfo?
    public static var unwrappedInfo: AppInfo {
        self.appInfo!
    }
    
    init(info: AppInfo) {
        Self.appInfo = info
    }
}
