import XCTest
@testable import DoKostola

final class Number_StringTests: XCTestCase {

	func testParseWithInt() {
		XCTAssertEqual("1234567890", 1234567890.string)
	}

	func testParseWithDouble() {
		XCTAssertEqual("1.23456789", 1.23456789.string)
		XCTAssertEqual(1.23456789, "1.23456789".double)
		XCTAssertNil("1,23456789".double)
	}

	func testParseWithBool() {
		XCTAssertEqual(true, "1".bool)
		XCTAssertEqual(false, "0".bool)
		XCTAssertEqual(false, "10".bool)
		XCTAssertEqual(true, "true".bool)
		XCTAssertEqual(false, "false".bool)
		XCTAssertEqual(false, "".bool)
		XCTAssertEqual(false, "any".bool)
	}
}
