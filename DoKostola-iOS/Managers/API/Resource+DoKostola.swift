import Foundation

extension Resource {
	static var allCities: Resource {
		.init(
			url: "https://api.dokostola.sk",
			path: "/abcdefgh/cities"
		)
	}

	static var allChurches: Resource {
		.init(
			url: "https://api.dokostola.sk",
			path: "/abcdefgh/churches"
		)
	}

	static var allFeasts: Resource {
		.init(
			url: "https://api.dokostola.sk",
			path: "/abcdefgh/feasts"
		)
	}

	static func masses(
		location: Location,
		time: Date,
		distance: Int = 1,
		church: ChurchId = "0"
	) -> Resource {

		let path = [
			"masses",
			church,
            DateFormatter.yearMonthDay.string(from: time),
			location.latitude.string,
			location.longitude.string,
			distance.string
			]
			.joined(separator: "/")
		return .init(
			url: "https://api.dokostola.sk",
			path: "/abcdefgh/\(path)"
		)
	}
}
