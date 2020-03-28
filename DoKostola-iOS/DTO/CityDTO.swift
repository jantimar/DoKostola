import Foundation

typealias CityId = String

struct CityDTO: Codable {
	var city: CityId
	var title: String
	var lat: String?
	var lng: String?
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
