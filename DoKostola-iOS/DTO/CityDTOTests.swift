import XCTest
@testable import DoKostola

final class CityDTOTests: XCTestCase {

	func testDecode() throws {
		let json = """
		{
			"title": "City_Title",
			"city": "City_Id",
			"lat": "Latitude",
			"lng": "Longitude"
		}
		""".data(using: .utf8)!

		let cityDTO = try JSONDecoder()
			.decode(CityDTO.self, from: json)

		XCTAssertEqual("City_Title", cityDTO.title)
		XCTAssertEqual("City_Id", cityDTO.city)
		XCTAssertEqual("Latitude", cityDTO.lat)
		XCTAssertEqual("Longitude", cityDTO.lng)
		XCTAssertEqual("""
		CityDTO:
		 - City_Id
		 - City_Title
		 - Optional("Latitude") x Optional("Longitude")
		""", cityDTO.description)
	}
}

