import XCTest
@testable import DoKostola

final class DateFormatter_TypesTests: XCTestCase {

	func testParseYearMonthDay() {
		let formatter: DateFormatter = .yearMonthDay
		guard let date = formatter.date(from: "2020-03-15") else {
			XCTFail("Unexpected state")
			return
		}

		let calendar = Calendar(identifier: .gregorian)
		let components = calendar.dateComponents(
			[.year, .month, .day],
			from: date
		)
		XCTAssertEqual(2020, components.year)
		XCTAssertEqual(3, components.month)
		XCTAssertEqual(15, components.day)
	}

}
