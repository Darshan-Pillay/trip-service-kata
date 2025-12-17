import Foundation

protocol TripDAOProtocol {
    func findTripsByUser(_ user:User) throws -> [Trip]?
}

class TripDAO: TripDAOProtocol
{
    class func findTripsByUser(_ user:User) throws -> [Trip]?
    {
        throw UnitTestErrorType.dependendClassCallDuringUnitTest
    }
    
    func findTripsByUser(_ user:User) throws -> [Trip]? {
        try TripDAO.findTripsByUser(user)
    }
}
