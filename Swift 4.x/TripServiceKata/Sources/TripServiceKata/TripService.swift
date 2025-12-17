import Foundation

class TripService
{
    var userSession: UserSessionProtocol = UserSession.sharedInstance
    var tripDAO: TripDAOProtocol = TripDAO()
    
    // Violate Dependency Inversion rule
    // High level trip level class depend on no abstraction but low level details
    
    // Violate object calisthenics rules.
    // - more than one level of indentation
    // - use else block
    func getTripsByUser(_ user:User) throws -> [Trip]?
    {
        var tripList:[Trip]? = nil
        let loggedUser = try! userSession.getLoggedUser()
        
        var isFriend = false
        
        if let loggedUser = loggedUser {
            for friend in user.getFriends() {
                if friend == loggedUser {
                    isFriend = true
                    break
                }
            }
            if isFriend {
                tripList = try! tripDAO.findTripsByUser(user)
            }
            return tripList
        }
        else {
            throw TripServiceErrorType.userNotLoggedIn
        }
    }
}
