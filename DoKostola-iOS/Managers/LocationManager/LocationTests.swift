import XCTest
import Combine
import CoreLocation
@testable import DoKostola

final class LocationTests: XCTestCase {

	private var locationManager: LocationManager!
	private var mockCLLocationManager: MockCLLocationManager!
	private var disposables = Set<AnyCancellable>()

    override func setUp() {
		mockCLLocationManager = MockCLLocationManager()
		locationManager = LocationManager(locationManager: mockCLLocationManager)

		super.setUp()
    }

	func testUpdateLocation() {
		let expectation = XCTestExpectation(description: "location-update")

		locationManager
			.publisher
			.sink(receiveCompletion: { result in
				switch result {
				case let .failure(error):
					XCTFail(error.localizedDescription)
				case .finished: break
				}
			}, receiveValue: { location in

				XCTAssertEqual(location.coordinate.latitude, CLLocation.mock.coordinate.latitude)
				XCTAssertEqual(location.coordinate.longitude, CLLocation.mock.coordinate.longitude)
				expectation.fulfill()
			}).store(in: &disposables)

		mockCLLocationManager.simulate(location: .mock)

		wait(for: [expectation], timeout: 1)
	}
}

private extension CLLocation {
	static let mock = CLLocation(latitude: 1, longitude: 2)
}
