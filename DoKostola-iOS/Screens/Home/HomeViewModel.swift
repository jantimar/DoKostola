import Foundation
import Combine

final class HomeViewModel: ObservableObject {

	/// Date for show `messes`, default value is today, can be set to date in future
	@Published var date = Date()
	/// Distance in `km` to show nearst `churches`
	@Published var distance = 25.0
	/// All churches in `distance`in `distacne` from current location
	@Published var churches = [Church]()

	var searchViewModel: SearchViewModel {
		SearchViewModel(repo: self.repo)
	}

	var infoViewModel: InfoViewModel {
		InfoViewModel()
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

		let locationQueue = DispatchQueue(label: "Location background queue")
		let locationPublisher = locationManager
			.publisher
			.receive(on: locationQueue)
			.removeDuplicates()
			.map(Location.init(clLocation:))
			.replaceError(with: Location(latitude: 0, longitude: 0))

		$distance
			.debounce(for: 0.5, scheduler: locationQueue)
			.removeDuplicates()
			.combineLatest(locationPublisher)
			.map(self.repo.churches)
			.receive(on: RunLoop.main)
			.assign(to: \.churches, on: self)
			.store(in: &disposables)
	}
}
