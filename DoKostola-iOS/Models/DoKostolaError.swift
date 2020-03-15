import Foundation

struct DoKostolaError: Error {
	let description: String
}

extension DoKostolaError {
	static let invaliDateFormat =  DoKostolaError(description: "Invalid date format")
}
