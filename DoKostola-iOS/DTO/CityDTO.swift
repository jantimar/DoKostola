import Foundation

typealias CityId = String

struct CityDTO: Codable {
	var title: String
	var city: CityId
	var lng: String?
	var lat: String?
}

extension CityDTO: CustomStringConvertible {
	var description: String {
		return """
		CityDTO:
		 - \(city)
		 - \(title)
		 - \(String(describing: lat)) x \(String(describing: lng))
		"""
	}
}
