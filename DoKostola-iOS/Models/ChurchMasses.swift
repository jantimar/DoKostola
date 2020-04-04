import Foundation

struct ChurchMasses {
    let church: Church
    let masses: [Mass]

    init(church: Church, massesDTO: [MassDTO]) {
        self.church = church
        self.masses = massesDTO
            .compactMap { try? Mass(massDTO: $0) }
    }
}

extension ChurchMasses: Identifiable {
    var id: String { church.cityId }
}
