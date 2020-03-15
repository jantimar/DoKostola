import Foundation

extension DateFormatter {
	/// Date formatter with `"YYYY-MM-dd"` format
	static var yearMonthDay: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

}
