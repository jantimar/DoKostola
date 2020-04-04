import XCTest
@testable import DoKostola

final class MassTests: XCTestCase {

    func testMass() throws {
        let massDTO = MassDTO(
            church: "church_id",
            date: "1970-01-01",
            time: "11:12:30",
            note: "Note"
        )

        let mass = try Mass(massDTO: massDTO)

        XCTAssertEqual("Note", mass.note)
        XCTAssertEqual(
            "1970-01-01",
            DateFormatter.yearMonthDay.string(from: mass.date)
        )
        XCTAssertEqual(
            "11:12:30",
            DateFormatter.hourMinutesSeconds.string(from: mass.time)
        )
    }

    func testInvalidMass() {
        let massDTO = MassDTO(
            church: "church_id",
            date: "19700101",
            time: "111230",
            note: "Note"
        )

        let mass = try? Mass(massDTO: massDTO)
        XCTAssertNil(mass)
    }
}
