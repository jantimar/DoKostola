import Foundation

struct FeastDTO: Decodable {
	var date: String // Time format YYYY-MM-dd
	var note: String
	var title: String
	var national: String // Int number
	var religious: String // Int number
	var traditional: String // Int number
}

extension FeastDTO: CustomStringConvertible {
	var description: String {
		return """
		FeastDTO:
		 - \(date)
		 - \(title.isEmpty ? "-" : title)
		 - \(note.isEmpty ? "-" : note)
		 - \(national)
		 - \(religious)
		 - \(traditional)
		"""
	}
}
