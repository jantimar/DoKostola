import Foundation
import Combine

/// Home screen state
final class HomeState: ObservableObject {
	/// Date for show `messes`, default value is today, can be set to date in future
	@Published var date = Date()
	/// Distance in `km` to show nearst `churches`
	@Published var distance = 25.0
	/// All churches in `distance`in `distacne` from current location
	@Published var churches = [Church]()
    /// Church with masses for current date, distance and location
    @Published var churchMasses = [ChurchMasses]()
}
