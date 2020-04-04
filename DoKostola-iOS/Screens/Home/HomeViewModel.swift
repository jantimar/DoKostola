import Foundation
import Combine

final class HomeViewModel: ObservableObject {

	/// Date for show `messes`, default value is today, can be set to date in future
	@Published var date = Date()
	/// Distance in `km` to show nearst `churches`
	@Published var distance = 25.0
	/// All churches in `distance`in `distacne` from current location
	@Published var churches = [Church]()
    /// Church with masses for current date, distance and location
    @Published var churchMasses = [ChurchMasses]()

    /// Search screen ViewModel
	var searchViewModel: SearchViewModel { SearchViewModel(repo: self.repo) }
    /// Info screen ViewModel
	var infoViewModel: InfoViewModel { InfoViewModel() }

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
            .replaceError(with: .kosice)

		$distance
			.debounce(for: 0.5, scheduler: locationQueue)
			.removeDuplicates()
			.combineLatest(locationPublisher)
			.map(repo.churches)
			.receive(on: RunLoop.main)
			.assign(to: \.churches, on: self)
			.store(in: &disposables)

        let distanceInKm = $distance
            .map(Int.init(_:))
            .removeDuplicates()

        let massesQueue = DispatchQueue(label: "Masses background queue")
        $date
            .debounce(for: 0.5, scheduler: massesQueue)
            .combineLatest(locationPublisher, distanceInKm)
            .flatMap {
                self.apiService.masses(date: $0, location: $1, distance: $2)
                    .replaceError(with: MassasResponse(allMasses: []))
        }
        .map(\.allMasses)
        .map { churchMasses -> [ChurchMasses] in
            return churchMasses.compactMap {
                guard let church = self.repo.search(churchId: $0.church) else { return nil }
                return ChurchMasses(church: church, massesDTO: $0.masses)
            }
        }
        .receive(on: RunLoop.main)
        .assign(to: \.churchMasses, on: self)
        .store(in: &disposables)
    }
}
