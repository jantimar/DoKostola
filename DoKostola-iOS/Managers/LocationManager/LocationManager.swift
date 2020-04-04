import Foundation
import CoreLocation
import Combine

/// Combine wrapper for CLLocationManager
final class LocationManager: NSObject {

    /// Combine publisher for update CLLocation or Error when occure
	let publisher: AnyPublisher<CLLocation, Error>

    /// Create new CLLotacitonManager and ask for authorize permission if needed, if have or get permission start updating location
    /// - Parameter locationManager: CLLocationManager
	init(locationManager: CLLocationManager = .init()) {
		self.locationManager = locationManager
		self.publisher = subject.eraseToAnyPublisher()
		super.init()
		self.locationManager.delegate = self
		self.locationManager.requestWhenInUseAuthorization()
	}

    /// Start update location, this method is call when init `LocationManager` or get authorize permission
	func start() {
		locationManager.startUpdatingLocation()
	}

    /// Stop updating location manager, call this method when you don't want any update anymore
	func stop() {
		locationManager.stopUpdatingLocation()
	}

    // MARK: - Private

    private let locationManager: CLLocationManager
    private let subject = PassthroughSubject<CLLocation, Error>()
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		subject.send(location)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		subject.send(completion: Subscribers.Completion.failure(error))
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedWhenInUse else { return }
		start()
	}
}
