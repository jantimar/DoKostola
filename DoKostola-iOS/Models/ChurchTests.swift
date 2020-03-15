import XCTest
@testable import DoKostola

final class ChurchTests: XCTestCase {

	func testChurch() {
		let churchDTO = ChurchDTO(
			church: "Church_Id",
			title: "Title",
			city: "City_Id",
			lat: "1.234",
			lng: "5.678",
			desc: "Description",
			image: "http://image.com",
			thumbnail: "http://thumbnail.com",
			alias: "Alias"
		)

		let church = Church(churchDTO: churchDTO)
		XCTAssertEqual("Title", church.title)
		XCTAssertEqual("Church_Id", church.id)
		XCTAssertEqual("City_Id", church.cityId)
		XCTAssertEqual(1.234, church.location?.latitude)
		XCTAssertEqual(5.678, church.location?.longitude)
		XCTAssertEqual("Description", church.description)
		XCTAssertEqual("http://image.com", church.imageURL?.absoluteString)
		XCTAssertEqual("http://thumbnail.com", church.thumbnailURL?.absoluteString)
		XCTAssertEqual("Alias", church.alias)
	}
}
