import Foundation

struct Feast {
	let title: String
	let note: String
	let national: Bool
	let religious: Bool
	let traditional: Bool
	let date: Date

	init(
		feastDTO: FeastDTO,
		dateFormatter: DateFormatter = .yearMonthDay
	) throws {
		guard let date = dateFormatter.date(from: feastDTO.date) else {
			throw DoKostolaError.invaliDateFormat
		}

		self.title = feastDTO.title
		self.note = feastDTO.note
		self.national = feastDTO.national.bool
		self.religious = feastDTO.religious.bool
		self.traditional = feastDTO.traditional.bool
		self.date = date
	}
}
