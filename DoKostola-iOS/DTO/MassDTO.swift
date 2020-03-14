import Foundation

struct MassDTO: Decodable {
	var church: ChurchId
	var date: String // Time format YYYY-MM-dd
	var time: String // Time format HH:mm:ss
	var note: String
}

extension MassDTO: CustomStringConvertible {
	var description: String {
		return """
		MassDTO:
		 - \(church)
		 - \(date)
		 - \(time)
		 - \(note)
		"""
	}
}
