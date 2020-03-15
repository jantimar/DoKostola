import XCTest
@testable import DoKostola

final class CityTests: XCTestCase {

	func testCity() {
		let cityDTO = CityDTO(
			title: "Title",
			city: "City_Id",
			lng: "1.234",
			lat: "5.678"
		)

		let city = City(cityDTO: cityDTO)
		XCTAssertEqual("Title", city.title)
		XCTAssertEqual("City_Id", city.id)
		XCTAssertEqual(1.234, city.location?.longitude)
		XCTAssertEqual(5.678, city.location?.latitude)
	}
}
