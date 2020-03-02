import Foundation
import Combine

protocol DoKostolaAPIServiceProtocol {
	func allCities() -> AnyPublisher<CitiesResponse, APIError>
	func allChurches() -> AnyPublisher<ChurchesResponse, APIError>
}

final class DoKostolaAPIService: APIService { }

extension DoKostolaAPIService: DoKostolaAPIServiceProtocol {
	func allCities() -> AnyPublisher<CitiesResponse, APIError> {
		return fetch(with: .allCities)
	}

	func allChurches() -> AnyPublisher<ChurchesResponse, APIError> {
		return fetch(with: .allChurches)
	}
}

extension Resource {
	static var allCities: Resource {
		.init(
			url: "https://api.dokostola.sk",
			method: .get,
			path: "/abcdefgh/cities"
		)
	}

	static var allChurches: Resource {
		.init(
			url: "https://api.dokostola.sk",
			method: .get,
			path: "/abcdefgh/churches"
		)
	}

}
