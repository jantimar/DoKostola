import Foundation
import CoreLocation

struct Location {
	let latitude: Double
	let longitude: Double

	func distance(from location: Location) -> Double {
		location.clLocation.distance(from: clLocation)
	}

	init?(latitude: String?, longitude: String?) {
		guard
			let latitude = latitude?.double,
			let longitude = longitude?.double else {
			return nil
		}

		self.latitude = latitude
		self.longitude = longitude
	}

	private var clLocation: CLLocation {
		CLLocation(latitude: self.latitude, longitude: self.longitude)
	}
}
