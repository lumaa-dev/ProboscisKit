//Made by Lumaa

import Foundation

public protocol AppInfo: Codable {
    var scopes: [AppScopes] { get }
    /// Your app's URL Scheme
    var scheme: String { get }
    /// Your app's name
    var appName: String { get }
    /// The default server when no server is specified
    var defaultServer: String { get }
    /// An "About" URL when Mastodon users tap on the name of your app when shown
    var aboutApp: URL { get }
    
    init(scopes: [AppScopes], scheme: String, clientName: String, defaultServer: String, aboutApp: URL)
}

extension AppInfo {
    public var stringScopes: String {
        self.scopes.map({ $0.rawValue }).joined(separator: " ")
    }
}

public struct ClientInfo: AppInfo {
    public let scopes: [AppScopes]
    /// Your app's URL Scheme
    public let scheme: String
    /// Your app's client name
    public let clientName: String
    /// The default server when no server is specified
    public let defaultServer: String
    /// An "About" URL when Mastodon users tap on the name of your app when shown
    public let aboutApp: URL
    
    public var appName: String {
        self.clientName
    }
    
    public init(scopes: [AppScopes] = [.read, .write, .follow, .push], scheme: String, clientName: String, defaultServer: String, aboutApp: URL) {
        self.scopes = scopes
        self.scheme = scheme
        self.clientName = clientName
        self.defaultServer = defaultServer
        self.aboutApp = aboutApp
    }
}
