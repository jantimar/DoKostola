import CoreLocation
import Combine

final class DetailState: ObservableObject {
    /// Date for show `messes`, default value is today, can be set to date in future
    @Published var date = Date()
    /// User friendly location name in format `City, street`
    @Published var address = ""
    /// Church with masses for current date, distance and location
    @Published var churchMasses: ChurchMasses

    init(churchMasses: ChurchMasses) {
        self.churchMasses = churchMasses
    }
}
