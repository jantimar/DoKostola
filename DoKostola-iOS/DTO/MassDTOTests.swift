import XCTest
@testable import DoKostola

final class MassDTOTests: XCTestCase {

	func testDecode() throws {
		let json = """
		{
			"church": "Church_Id",
			"date": "Date",
			"time": "Time",
			"note": "Note"
		}
		""".data(using: .utf8)!

		let massDTO = try JSONDecoder()
			.decode(MassDTO.self, from: json)

		XCTAssertEqual("Church_Id", massDTO.church)
		XCTAssertEqual("Date", massDTO.date)
		XCTAssertEqual("Time", massDTO.time)
		XCTAssertEqual("Note", massDTO.note)
		XCTAssertEqual("""
		MassDTO:
		 - Church_Id
		 - Date
		 - Time
		 - Note
		""", massDTO.description)
	}
}

