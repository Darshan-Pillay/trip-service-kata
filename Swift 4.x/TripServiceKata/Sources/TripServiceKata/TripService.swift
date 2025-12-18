import Foundation

class TripService {
    var userSession: UserSessionProtocol = UserSession.sharedInstance
    var tripDAO: TripDAOProtocol = TripDAO()
    
    func getTripsByUser(_ user:User) throws -> [Trip]? {
        let loggedUser = try! userSession.getLoggedUser()
        
        guard let loggedUser else {
            throw TripServiceErrorType.userNotLoggedIn
        }
        
        guard isUser(user, friendsWith: loggedUser) else {
            return nil
        }
        
        let usersTrips = try! tripDAO.findTripsByUser(user)
        
        return usersTrips
    }
    
    private func isUser(
        _ user: User,
        friendsWith otherUser: User
    ) -> Bool {
        var isFriendWithOtherUser = false
        
        for friend in user.getFriends() {
            if friend == otherUser {
                isFriendWithOtherUser = true
                break
            }
        }
        
        return isFriendWithOtherUser
    }
}
