import XCTest
@testable import TripServiceKata

// GOAL: Get 100% Test coverage

// Constraints:
// 1. No code can be changed unless there are tests covering that logic
// 2. You cannot cannot change the public interface of Trip service
// - No constructor can change
// - No method signature can change
// 3. You cannot add any state to the trip service class

class TripServiceKataTests: XCTestCase {
    private var systemUnderTest: TripService!
    private var mockUserSession: MockUserSession!
    private var mockTripDAO: MockTripDAO!
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        mockUserSession = MockUserSession()
        mockTripDAO = MockTripDAO()
        
        systemUnderTest = TripService()
        systemUnderTest.userSession = mockUserSession
        systemUnderTest.tripDAO = mockTripDAO
    }
}

extension TripServiceKataTests {
    func test_ifYouAreNotLoggedIn_thenYouCannotSeeAnyTripContent() throws {
        // Arrange
        let stubbedUser = User()
        mockUserSession.loggedUser = nil
        mockUserSession.isUserLoggedIn = false
        
        do {
            // Act
            _ = try systemUnderTest.getTripsByUser(stubbedUser)
            XCTFail("expected user not logged in error, bu tno error this thrown")
        } catch let error {
            // Assert
            guard
                let tripServiceError = error as? TripServiceErrorType
            else {
                XCTFail("expected trip service error, but got \(error)")
                return
            }
            
            guard
                case .userNotLoggedIn = tripServiceError
            else {
                XCTFail("expected userNotLoggedIn error, but got \(tripServiceError)")
                return
            }
        }
    }
}

extension TripServiceKataTests {
    func test_ifYouAreLoggedIn_thenYouCanSeeTripContent() {
        // Arrange
        let yourStubbedUser = User()
        let stubbedFriend = User()
        
        mockUserSession.loggedUser = yourStubbedUser
        mockUserSession.isUserLoggedIn = true
        
        // Act
        do {
            _ = try systemUnderTest.getTripsByUser(stubbedFriend)
        } catch let error {
            XCTFail("expected to see trip content, but got error: \(error)")
        }
    }
}

extension TripServiceKataTests {
    func test_ifYouAreSomeonesFriend_thenYouCanSeeTheirTripContent() {
        // Arrange
        let yourStubbedUser = User()
        
        let stubbedFriend = User()
        let friendsStubbedTrip = Trip()
        stubbedFriend.addTrip(friendsStubbedTrip)
        stubbedFriend.addFriend(yourStubbedUser)
        
        mockUserSession.loggedUser = yourStubbedUser
        mockUserSession.isUserLoggedIn = true
        
        // Act
        do {
            let friendsTrips = try systemUnderTest.getTripsByUser(stubbedFriend)
            XCTAssertEqual(friendsTrips?.count, 1)
            XCTAssertIdentical(friendsTrips?.first, friendsStubbedTrip)
        } catch let error {
            XCTFail("expected to see trip content, but got error: \(error)")
        }
    }
}

extension TripServiceKataTests {
    func test_ifYouAreNotSomeonesFriend_thenYouCannotSeeTheirTripContent() {
        // Arrange
        let yourStubbedUser = User()
        let stubbedFriend = User()
        
        mockUserSession.loggedUser = yourStubbedUser
        mockUserSession.isUserLoggedIn = true
        
        // Act
        do {
            let friendsTrips = try systemUnderTest.getTripsByUser(stubbedFriend)
            XCTAssertNil(friendsTrips)
        } catch let error {
            XCTFail("expected to see trip content, but got error: \(error)")
        }
    }
}
