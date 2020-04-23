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
        XCTAssertEqual("2020-03-15", formatter.string(from: date))
    }

    func testParseHourMinutesSeconds() {
        let formatter: DateFormatter = .hourMinutesSeconds
        guard let date = formatter.date(from: "17:21:04") else {
            XCTFail("Unexpected state")
            return
        }

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            [.hour, .minute, .second],
            from: date
        )
        XCTAssertEqual(17, components.hour)
        XCTAssertEqual(21, components.minute)
        XCTAssertEqual(4, components.second)
        XCTAssertEqual("17:21:04", formatter.string(from: date))
    }

    func testParseHourMinutes() {
        let formatter: DateFormatter = .hourMinutes
        guard let date = formatter.date(from: "17:21") else {
            XCTFail("Unexpected state")
            return
        }

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            [.hour, .minute],
            from: date
        )
        XCTAssertEqual(17, components.hour)
        XCTAssertEqual(21, components.minute)
        XCTAssertEqual("17:21", formatter.string(from: date))
    }
}
