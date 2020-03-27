import Foundation

struct Church: Identifiable {
	let title: String
	let id: ChurchId
	let location: Location?
	let cityId: CityId
	let description: String
	let imageURL: URL?
	let thumbnailURL: URL?
	let alias: String

	init(churchDTO: ChurchDTO) {
		self.title = churchDTO.title
		self.id = churchDTO.church
		self.cityId = churchDTO.city
		self.location = Location(
			latitude: churchDTO.lat,
			longitude: churchDTO.lng
		)
		self.description = churchDTO.desc
		self.imageURL = URL(string: churchDTO.image ?? "")
		self.thumbnailURL = URL(string: churchDTO.thumbnail ?? "")
		self.alias = churchDTO.alias
	}
}
