import XCTest
@testable import DoKostola

final class FeastDTOTests: XCTestCase {

	func testDecode() throws {
		let json = """
		{
			"title": "Title",
			"date": "Date",
			"note": "Note",
			"national": "1",
			"religious": "2",
			"traditional": "3"
		}
		""".data(using: .utf8)!

		let feastDTO = try JSONDecoder()
			.decode(FeastDTO.self, from: json)

		XCTAssertEqual("Title", feastDTO.title)
		XCTAssertEqual("Date", feastDTO.date)
		XCTAssertEqual("Note", feastDTO.note)
		XCTAssertEqual("1", feastDTO.national)
		XCTAssertEqual("2", feastDTO.religious)
		XCTAssertEqual("3", feastDTO.traditional)
		XCTAssertEqual("""
		FeastDTO:
		 - Date
		 - Title
		 - Note
		 - 1
		 - 2
		 - 3
		""", feastDTO.description)
	}
}

