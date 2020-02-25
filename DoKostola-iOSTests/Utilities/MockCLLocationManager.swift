import Foundation
import CoreLocation

final class MockCLLocationManager: CLLocationManager {

	private var _location: CLLocation?
	override var location: CLLocation? { _location }

	override func requestAlwaysAuthorization() { }

	override func requestWhenInUseAuthorization() {	}

	override func startUpdatingLocation() {	}

	override func stopUpdatingLocation() { }
}

extension MockCLLocationManager {
	func simulate(location: CLLocation) {
		_location = location
		delegate?.locationManager?(self, didUpdateLocations: [location])
	}
}
