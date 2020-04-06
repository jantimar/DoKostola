import Foundation
import CoreLocation
import Combine

/// Comibne wrapper for CLGeocoder
struct Geocoder {

    /// Default CLGeocoder instance, which can be override during initialize Geocoder
    var geocoder: CLGeocoder = .init()

    /// Return `CPLacemark` publisher for specific location
    /// - Parameter location: Location for get `CLPlacemark`
    func reverseGeocode(location: Location) -> AnyPublisher<CLPlacemark, Error> {
        let subject = PassthroughSubject<CLPlacemark, Error>()
        geocoder.reverseGeocodeLocation(
            location.clLocation
        ) { (placemarks, error) in
            if let placemark = placemarks?.first { // Handle placemark
                subject.send(placemark)
            } else if let error = error { // Handle error
                subject.send(completion: Subscribers.Completion.failure(error))
            } else {
                subject.send(completion: Subscribers.Completion.failure(DoKostolaError.missingPlacemark))
            }
        }

        return subject.eraseToAnyPublisher()
    }
}
