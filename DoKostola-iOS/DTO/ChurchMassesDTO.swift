import Foundation

struct ChurchMassesDTO: Decodable {
	var church: ChurchId
	var masses: [MassDTO]
	var nearest: String // Time format HH:mm:ss
}
