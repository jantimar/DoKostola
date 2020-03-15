import Foundation

struct Location {
	let latitude: Double
	let longitude: Double

	init?(latitude: String?, longitude: String?) {
		guard
			let latitude = latitude?.double,
			let longitude = longitude?.double else {
			return nil
		}

		self.latitude = latitude
		self.longitude = longitude
	}
}
