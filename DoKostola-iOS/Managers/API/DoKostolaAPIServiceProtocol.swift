import Foundation
import Combine

typealias Location = (latitude: Double, longitude: Double)

protocol DoKostolaAPIServiceProtocol {
	/// GET all cities
	func cities() -> AnyPublisher<CitiesResponse, APIError>
	/// GET all churches
	func churches() -> AnyPublisher<ChurchesResponse, APIError>
	/// GET all feasts
	func feasts() -> AnyPublisher<FeastsResponse, APIError>
}
