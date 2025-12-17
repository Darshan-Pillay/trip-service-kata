import Foundation

protocol UserSessionProtocol {
    func isUserLoggedIn(_ user:User) throws -> Bool
    func getLoggedUser() throws -> User?
}

class UserSession: UserSessionProtocol
{
    static var sharedInstance:UserSession = UserSession()
    
    func isUserLoggedIn(_ user:User) throws -> Bool
    {
        throw UnitTestErrorType.dependendClassCallDuringUnitTest
    }
    
    func getLoggedUser() throws -> User?
    {
        throw UnitTestErrorType.dependendClassCallDuringUnitTest
    }
}
