import Foundation

struct City: Identifiable {
	let title: String
	let id: CityId
	let location: Location?

	init(cityDTO: CityDTO) {
		self.title = cityDTO.title
		self.id = cityDTO.city
		self.location = Location(
			latitude: cityDTO.lat,
			longitude: cityDTO.lng
		)
	}
}
