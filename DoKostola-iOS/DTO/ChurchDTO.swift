import Foundation

typealias ChurchId = String

struct ChurchDTO: Codable {
	let church: ChurchId
	let title: String
	let city: CityId
	let lat: String?
	let lng: String?
	let desc: String
	let image: String?
	let thumbnail: String?
	let alias: String
}

extension ChurchDTO: CustomStringConvertible {
	var description: String {
		return """
		ChurchDTO:
		 - \(title.isEmpty ? "-" : title)
		 - \(city)
		 - \(String(describing: lat)) x \(String(describing: lng))
		 - \(desc)
		 - \(String(describing: image))
		 - \(String(describing: thumbnail))
		 - \(alias)
		"""
	}
}
