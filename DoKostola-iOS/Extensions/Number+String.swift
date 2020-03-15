import Foundation

extension Int {
	var string: String {
		return String(self)
	}
}

extension Double {
	var string: String {
		return String(self)
	}
}

extension String {
	var double: Double? {
		return Double(self)
	}
}

extension String {
	/// Default value is false when string is not true or 1
	var bool: Bool {
		return Int(self) == 1 || Bool(self) == true
	}
}
