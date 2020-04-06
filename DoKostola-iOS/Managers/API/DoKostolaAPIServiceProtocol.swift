import Foundation
import Combine

protocol DoKostolaAPIServiceProtocol {
	/// GET all cities
	func cities() -> AnyPublisher<CitiesResponse, APIError>
	/// GET all churches
	func churches() -> AnyPublisher<ChurchesResponse, APIError>
	/// GET all feasts
	func feasts() -> AnyPublisher<FeastsResponse, APIError>
	/// GET masses from specific location
    func masses(
        date: Date,
        location: Location,
        distance: Int
    ) -> AnyPublisher<MassasResponse, APIError>
    /// GET masses from specific church
    func masses(
        date: Date,
        church: Church
    ) -> AnyPublisher<MassasResponse, APIError>
}
