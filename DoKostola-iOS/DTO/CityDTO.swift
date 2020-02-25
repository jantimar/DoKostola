import Foundation

struct CityDTO: Codable {
	var title: String
	var city: String
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
