import Foundation
import Combine

final class HomeViewModel: ObservableObject {

	/// Date for show `messes`, default value is today, can be set to date in future
	@Published var date = Date()
	/// Distance in `km` to show nearst `churches`
	@Published var distance = 25
	/// All churches in `distance`in `distacne` from current location
	@Published var churches = [Church]()

	var searchViewModel: SearchViewModel {
		return SearchViewModel()
	}

	var infoViewModel: InfoViewModel {
		return InfoViewModel()
	}

	init(
		apiService: DoKostolaAPIServiceProtocol,
		repo: Repo,
		locationManager: LocationManager = LocationManager()
	) {
		self.apiService = apiService
		self.repo = repo
		self.locationManager = locationManager
		self.setup()
	}

	// MARK: - Private

	private let apiService: DoKostolaAPIServiceProtocol
	private let repo: Repo
	private let locationManager: LocationManager
	private var disposables = Set<AnyCancellable>()

	private func setup() {
		
//		locationManager
//			.publisher
//			.dropFirst(3)
//			.combineLatest(apiService.allCities())
	}
}
