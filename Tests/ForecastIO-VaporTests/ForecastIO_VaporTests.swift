import XCTest
@testable import ForecastIO_Vapor
@testable import HTTP

final class ForecastIO_VaporTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let expectation = XCTestExpectation(description: "Fetch Forecast")


        let worker = MultiThreadedEventLoopGroup(numThreads: 1)
        let client = DarkSkyClient(apiKey: "")
        let response = try! client.getWeather(latitude: 42.7, longitude: -76.2, time: nil, worker: worker)
        response.do { (forecast) in
            expectation.fulfill()
            }.catch { error in
                print(error)
        }

        wait(for: [expectation], timeout: 10.0)
        
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
