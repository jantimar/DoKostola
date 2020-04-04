import XCTest
@testable import DoKostola

final class FeastTests: XCTestCase {

	func testFeast() throws {
		let feastDTO = FeastDTO(
			date: "1970-01-01",
			note: "Note",
			title: "Title",
			national: "1",
			religious: "true",
			traditional: "1"
		)

		let feast = try Feast(feastDTO: feastDTO)
		XCTAssertEqual("Title", feast.title)
		XCTAssertEqual("Note", feast.note)
		XCTAssertEqual(true, feast.national)
		XCTAssertEqual(true, feast.religious)
		XCTAssertEqual(true, feast.traditional)
		XCTAssertEqual(
			"1970-01-01",
			DateFormatter.yearMonthDay.string(from: feast.date)
		)
	}

    func testInvalidFeast() {
        let feastDTO = FeastDTO(
            date: "Invalid date",
            note: "Note",
            title: "Title",
            national: "1",
            religious: "true",
            traditional: "1"
        )

        let feast = try? Feast(feastDTO: feastDTO)
        XCTAssertNil(feast)
    }
}
