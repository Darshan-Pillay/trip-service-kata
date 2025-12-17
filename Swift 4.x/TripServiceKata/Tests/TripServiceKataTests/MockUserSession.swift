@testable import TripServiceKata

class MockUserSession: UserSessionProtocol {
    var isUserLoggedIn: Bool = false
    var loggedUser: User? = nil
    
    func isUserLoggedIn(_ user: User) throws -> Bool {
        isUserLoggedIn
    }

    func getLoggedUser() throws -> User? {
        loggedUser
    }
}
