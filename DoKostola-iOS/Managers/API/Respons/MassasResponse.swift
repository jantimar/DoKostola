import Foundation

struct MassasResponse: Decodable {
	private enum CodingKeys : String, CodingKey {
        case allMasses = "allmasses"
    }

	var allMasses: [ChurchMassesDTO]
}

extension MassasResponse {
    static let empty = MassasResponse(allMasses: [])
}
