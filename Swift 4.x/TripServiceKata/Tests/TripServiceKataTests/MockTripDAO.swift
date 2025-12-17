@testable import TripServiceKata

class MockTripDAO: TripDAOProtocol {
    func findTripsByUser(_ user:User) throws -> [Trip]? {
        var trips: [Trip]? = []
        trips?.append(contentsOf: user.trips())
        return trips
    }
}
