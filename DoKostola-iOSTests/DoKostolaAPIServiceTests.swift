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

		wait(for: [expectation], timeout: 1)
	}

	func testAllChurches() {
		let expectation = XCTestExpectation(description: "api-all-churches")

		MockURLProtocol.requestHandler = { request in
			guard request.url?.absoluteString == "https://api.dokostola.sk/abcdefgh/churches" else {
				throw MockURLProtocolError.invalidURL
			}

			return (
				HTTPURLResponse(),
				String.allChurchesAPIMock.data(using: .utf8)!
			)
		}

		apiService
			.allChurches()
			.sink(receiveCompletion: { result in
				switch result {
				case let .failure(error):
					XCTFail(error.localizedDescription)
				case .finished: break
				}
			}, receiveValue: { churchesResponse in

				let response = churchesResponse
					.churches
					.map { $0.description }
					.joined(separator: "\n")
				print(response)

				let pasteBoard = UIPasteboard.general
				pasteBoard.string = response

				XCTAssertEqual(response, .allChurchesResponse)
				expectation.fulfill()
			}).store(in: &disposables)

		wait(for: [expectation], timeout: 1)
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

	static let allChurchesAPIMock = """
	{"churches":[{"church":"412839","title":"","lat":"","lng":"","city":"30386","desc":"www.saldub.sk/index.php/kostoly-a-kaplnky/kaplnka-svjana.html","alias":"kaplnka-sv-jana-bosca"},{"church":"410219","title":"Bazilika narodenia Panny M\\u00e1rie","lat":"48.2480268","lng":"17.064570900000035","city":"30036","desc":"www.bazilikamarianka.sk Autobusov\\u00e9 spojenie http://marianka.sk/web/pictures2013/2013_07_01_linka_37.pdf","image":"http://www.dokostola.sk/content/images/m/marianka2_full.jpg","thumbnail":"http://www.dokostola.sk/content/images/m/marianka2_thumb.jpg","alias":"410219-bazilika-narodenia-panny-marie"}
	]}
	"""

	static let allChurchesResponse = """
	ChurcheDTO:
	 - -
	 - 30386
	 - Optional("") x Optional("")
	 - www.saldub.sk/index.php/kostoly-a-kaplnky/kaplnka-svjana.html
	 - nil
	 - nil
	 - kaplnka-sv-jana-bosca
	ChurcheDTO:
	 - Bazilika narodenia Panny Márie
	 - 30036
	 - Optional("48.2480268") x Optional("17.064570900000035")
	 - www.bazilikamarianka.sk Autobusové spojenie http://marianka.sk/web/pictures2013/2013_07_01_linka_37.pdf
	 - Optional("http://www.dokostola.sk/content/images/m/marianka2_full.jpg")
	 - Optional("http://www.dokostola.sk/content/images/m/marianka2_thumb.jpg")
	 - 410219-bazilika-narodenia-panny-marie
	"""
}
