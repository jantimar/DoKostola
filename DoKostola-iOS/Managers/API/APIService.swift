import Foundation
import Combine

enum APIError: Error {
	case network(String)
	case response(URLError)
	case parsing(Error)
}

extension APIError: CustomStringConvertible {
	var description: String {
		switch self {
		case let .network(description):
			return ".network: \(description)"
		case let .response(error):
			return ".response: \(error)"
		case let .parsing(error):
			return ".parsing: \(error)"
		}
	}
}

class APIService {
	private let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func fetch<T>(
		with resource: Resource
	) -> AnyPublisher<T, APIError> where T: Decodable {
		guard let request = try? URLRequest(resource: resource) else {
			return Fail(error: .network("Invalid URL"))
				.eraseToAnyPublisher()
		}
		
		return session
			.dataTaskPublisher(for: request)
			.mapError { .response($0) }
			.flatMap(maxPublishers: .max(1)) { self.decode($0.data) }
			.eraseToAnyPublisher()
	}
	
	private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		return Just(data)
			.decode(type: T.self, decoder: decoder)
			.mapError { .parsing($0) }
			.eraseToAnyPublisher()
	}
}
