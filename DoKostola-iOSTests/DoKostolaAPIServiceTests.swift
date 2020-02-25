import XCTest
import Combine
@testable import DoKostola

final class DoKostolaAPIServiceTests: XCTestCase {

	private var apiService: DoKostolaAPIServiceProtocol! = nil
	private var disposables = Set<AnyCancellable>()

	override func setUp() {
		let urlSession = URLSession(configuration: .mock)
		apiService = DoKostolaAPIService(session: urlSession)

		super.setUp()
	}

	func testAllCities() {
		let expectation = XCTestExpectation(description: "api-all-cities")

		MockURLProtocol.requestHandler = { request in
			guard request.url?.absoluteString == "https://api.dokostola.sk/abcdefgh/cities" else {
				throw MockURLProtocolError.invalidURL
			}

			return (
				HTTPURLResponse(),
				String.allCitiesAPIMock.data(using: .utf8)!
			)
		}

		apiService
			.allCities()
			.sink(receiveCompletion: { result in
				switch result {
				case let .failure(error):
					XCTFail(error.localizedDescription)
				case .finished: break
				}
			}, receiveValue: { citiesResponse in

				let response = citiesResponse
					.cities
					.map { $0.description }
					.joined(separator: "\n")
				print(response)

				XCTAssertEqual(response, .allCitiesResponse)
				expectation.fulfill()
			}).store(in: &disposables)

		wait(for: [expectation], timeout: 60)
	}
}

private extension String {

	static let allCitiesAPIMock = """
	{"cities":[
	 {"city":"30001","title":"Bratislava - mestsk\\u00e1 \\u010das\\u0165 Star\\u00e9 Mesto","lat":"48.143557","lng":"17.108424"},
	 {"city":"30002","title":"Bratislava - mestsk\\u00e1 \\u010das\\u0165 Podunajsk\\u00e9 Biskupice","lat":"48.125037","lng":"17.210866"},
	 {"city":"30003","title":"Bratislava - mestsk\\u00e1 \\u010das\\u0165 Ru\\u017einov","lat":"48.152793","lng":"17.164511"}
	]}
	"""

	static let allCitiesResponse = """
	CityDTO:
	 - 30001
	 - Bratislava - mestská časť Staré Mesto
	 - Optional("48.143557") x Optional("17.108424")
	CityDTO:
	 - 30002
	 - Bratislava - mestská časť Podunajské Biskupice
	 - Optional("48.125037") x Optional("17.210866")
	CityDTO:
	 - 30003
	 - Bratislava - mestská časť Ružinov
	 - Optional("48.152793") x Optional("17.164511")
	"""
}
