import XCTest
@testable import DoKostola

final class RepoTests: XCTestCase {

    func testSearchCitiesWithText() {
		let searchText = "cde12"
		let repo = Repo()
		repo.cities = .mock

        let result: [City] = repo.search(contain: searchText)
		XCTAssertEqual(3, result.count)
		XCTAssertEqual(["1", "3", "4"], result.map { $0.id })
    }

	func testSearchChurchesWithText() {
		let searchText = "cde12"
		let repo = Repo()
		repo.churches = .mock

        let result: [Church] = repo.search(contain: searchText)
		XCTAssertEqual(3, result.count)
		XCTAssertEqual(["1", "3", "4"], result.map { $0.id })
    }

    func testSearchCityWithId() {
        let searchId = "3"
        let repo = Repo()
        repo.cities = .mock

        let result = repo.search(cityId: searchId)
        XCTAssertEqual("3", result?.id)
    }

    func testSearchChurchWithId() {
        let searchId = "4"
        let repo = Repo()
        repo.churches = .mock

        let result = repo.search(churchId: searchId)
        XCTAssertEqual("4", result?.id)
    }

	func testNearChurches() {
		let location = Location(latitude: "14.42076", longitude: "50.08804")!
		let repo = Repo()
		repo.churches = .mock

		let result = repo.churches(in: 1, from: location)
		XCTAssertEqual(3, result.count)
		XCTAssertEqual(["1", "5", "3"], result.map { $0.id })
	}
}

private extension Array where Element == City {
	static var mock: [City] {
		return [
			City(cityDTO: CityDTO(city: "1", title: "abcde123", lat: "14.42076", lng: "50.08804")),
			City(cityDTO: CityDTO(city: "2", title: "whaat456", lat: "14.42086", lng: "50.08804")),
			City(cityDTO: CityDTO(city: "3", title: "AbcDe123", lat: "14.42276", lng: "50.08804")),
			City(cityDTO: CityDTO(city: "4", title: "ábČde123", lat: nil, lng: nil)),
			City(cityDTO: CityDTO(city: "5", title: "", lat: "14.42176", lng: "50.08804")),
			City(cityDTO: CityDTO(city: "6", title: "", lat: nil, lng: nil))
		]
	}
}

private extension Array where Element == Church {
	static var mock: [Church] {
		return [
			Church(churchDTO: ChurchDTO(church: "1", title: "abcde123", city: "1", lat: "14.42076", lng: "50.08804", desc: "", image: nil, thumbnail: nil, alias: "")),
			Church(churchDTO: ChurchDTO(church: "2", title: "whaat456", city: "2", lat: "16.42086", lng: "50.08804", desc: "", image: nil, thumbnail: nil, alias: "")),
			Church(churchDTO: ChurchDTO(church: "3", title: "AbcDe123", city: "3", lat: "14.42276", lng: "50.08804", desc: "", image: nil, thumbnail: nil, alias: "")),
			Church(churchDTO: ChurchDTO(church: "4", title: "ábČde123", city: "4", lat: nil, lng: nil, desc: "", image: nil, thumbnail: nil, alias: "")),
			Church(churchDTO: ChurchDTO(church: "5", title: "", city: "5", lat: "14.42176", lng: "50.08804", desc: "", image: nil, thumbnail: nil, alias: "")),
			Church(churchDTO: ChurchDTO(church: "6", title: "", city: "6", lat: nil, lng: nil, desc: "", image: nil, thumbnail: nil, alias: ""))
		]
	}
}
