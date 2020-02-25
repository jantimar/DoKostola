import Foundation

extension URLRequest {
	init?(resource: Resource) throws {
		var components = URLComponents(string: resource.url)
		components?.path = resource.path
		guard let url = components?.url else {
			throw APIError.network("Invalid URL")
		}

		self.init(url: url)
	}
}
