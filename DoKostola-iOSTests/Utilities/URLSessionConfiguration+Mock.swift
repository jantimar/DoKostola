import Foundation

extension URLSessionConfiguration {
	static var mock: URLSessionConfiguration {
		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [MockURLProtocol.self]
		return configuration
	}
}
