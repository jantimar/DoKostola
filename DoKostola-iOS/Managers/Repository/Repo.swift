import Foundation
import Combine

// In-memory database
final class Repo {

	var cities: [City] = []
    var feasts: [Feast] = []
    var churches: [Church] = []

	/// Get all cities which contain `text` in `title`, caseInsensitive and diacriticInsensitive
	/// - Parameter text: String which should be in city.title
	func search(contain text: String) -> [City] {
		cities.filter { $0.title.range(of: text, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
	}

	/// Get all churches which contain `text` in `title`, caseInsensitive and diacriticInsensitive
	/// - Parameter text: String which should be in church.title
	func search(contain text: String) -> [Church] {
		churches.filter { $0.title.range(of: text, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
	}

    /// Find city with specific `id`
    /// - Parameter id: City identifier
    func search(cityId: CityId) -> City? {
        cities.first { $0.id == cityId }
    }

    /// Find church with specific `id`
    /// - Parameter id: Church identifier
    func search(churchId: ChurchId) -> Church? {
        churches.first { $0.id == churchId }
    }

	/// Get all churches from `location` sorted by distance
	/// - Parameters:
	///   - distance: Distance for search in `km`
	///   - location: Location where should start search Churches
	func churches(in distance: Double, from location: Location) -> [Church] {
		let distanceInMeters = distance * 1000
		return churches.filter { church in
			guard let churchLocation = church.location else { return false }
			return churchLocation.distance(from: location) <= distanceInMeters
		}.sorted { (church1, church2) in
			guard let distance1 = church1.location?.distance(from: location) else { return false }
			guard let distance2 = church2.location?.distance(from: location) else { return true }
			return distance1 < distance2
		}
	}
}
