//Made by Lumaa

import Foundation

/// The default ProboscisKit ``AccountManager``
@Observable
public class AccountManager: ObservableObject {
    private var client: Client?
    private var account: Account?
    
    public static var shared: AccountManager = AccountManager()
    
    init(client: Client? = nil, account: Account? = nil) {
        self.client = client
        self.account = account
    }
    
    public func clear() {
        self.client = nil
        self.account = nil
    }
    
    public func setClient(_ client: Client) {
        self.client = client
    }
    
    public func getClient() -> Client? {
        return client
    }
    
    public func setAccount(_ account: Account) {
        self.account = account
    }
    
    public func getAccount() -> Account? {
        return account
    }
    
    /// If the client is not defined, the app will crash
    public func forceClient() -> Client {
        guard client != nil else { fatalError("Client is not existant in that context") }
        return client!
    }
    
    /// If the account is not defined, the app will crash
    public func forceAccount() -> Account {
        guard account != nil else { fatalError("Account is not existant in that context") }
        return account!
    }
    
    ///Fetches the currently logged account using the defined `client`
    public func fetchAccount() async -> Account? {
        guard client != nil else { fatalError("Client is not existant in that context") }
        account = try? await client!.get(endpoint: Accounts.verifyCredentials)
        return account
    }
}
