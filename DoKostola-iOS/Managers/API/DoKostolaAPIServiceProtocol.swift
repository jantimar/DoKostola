import Foundation
import Combine

protocol DoKostolaAPIServiceProtocol {
	func allCities() -> AnyPublisher<CitiesResponse, APIError>
}

final class DoKostolaAPIService: APIService { }

extension DoKostolaAPIService: DoKostolaAPIServiceProtocol {
	func allCities() -> AnyPublisher<CitiesResponse, APIError> {
		return fetch(with: .allCities)
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

}
