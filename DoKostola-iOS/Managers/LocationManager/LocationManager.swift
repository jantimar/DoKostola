import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject {

	let publisher: AnyPublisher<CLLocation, Error>

	private let locationManager: CLLocationManager
	private let subject = PassthroughSubject<CLLocation, Error>()

	init(locationManager: CLLocationManager = .init()) {
		self.locationManager = locationManager
		self.publisher = subject.eraseToAnyPublisher()
		super.init()
		self.locationManager.delegate = self
		start()
	}

	func start() {
		locationManager.startUpdatingLocation()
	}

	func stop() {
		locationManager.stopUpdatingLocation()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}

		subject.send(location)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		subject.send(completion: Subscribers.Completion.failure(error))
	}
}
