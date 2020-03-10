import Foundation
import Combine

final class DoKostolaAPIService: APIService, DoKostolaAPIServiceProtocol {

	// MARK: - DoKostolaAPIServiceProtocol

	/// GET all cities
	func cities() -> AnyPublisher<CitiesResponse, APIError> {
		return fetch(with: .allCities)
	}

	/// GET all churches
	func churches() -> AnyPublisher<ChurchesResponse, APIError> {
		return fetch(with: .allChurches)
	}

	/// GET all feasts
	func feasts() -> AnyPublisher<FeastsResponse, APIError> {
		return fetch(with: .allFeasts)
	}
}
