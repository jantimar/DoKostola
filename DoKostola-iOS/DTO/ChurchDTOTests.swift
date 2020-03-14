import XCTest
@testable import DoKostola

final class ChurchDTOTests: XCTestCase {

	func testDecode() throws {
		let json = """
		{
			"church": "Church_Id",
			"title": "Church_Title",
			"city": "City_Id",
			"lat": "Latitude",
			"lng": "Longitude",
			"desc": "Description",
			"image": "Image",
			"thumbnail": "Thumbnail",
			"alias": "Alias"
		}
		""".data(using: .utf8)!

		let churchDTO = try JSONDecoder()
			.decode(ChurchDTO.self, from: json)

		XCTAssertEqual("Church_Id", churchDTO.church)
		XCTAssertEqual("Church_Title", churchDTO.title)
		XCTAssertEqual("City_Id", churchDTO.city)
		XCTAssertEqual("Latitude", churchDTO.lat)
		XCTAssertEqual("Longitude", churchDTO.lng)
		XCTAssertEqual("Description", churchDTO.desc)
		XCTAssertEqual("Image", churchDTO.image)
		XCTAssertEqual("Thumbnail", churchDTO.thumbnail)
		XCTAssertEqual("Alias", churchDTO.alias)
		XCTAssertEqual("""
		ChurchDTO:
		 - Church_Title
		 - City_Id
		 - Optional("Latitude") x Optional("Longitude")
		 - Description
		 - Optional("Image")
		 - Optional("Thumbnail")
		 - Alias
		""", churchDTO.description)
	}
}
