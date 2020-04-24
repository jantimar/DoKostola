import Foundation
import Combine

/// Home screen interceptro
final class HomeInterceptor {
    /// Home screen state
    let state: HomeState

    /// Setup binding state to services
    func setup() {
        // Setup updates on location
        let locationQueue = DispatchQueue(label: "Location background queue")
        let locationPublisher = locationManager
            .publisher
            .receive(on: locationQueue)
            .removeDuplicates()
            .map(Location.init(clLocation:))
            .replaceError(with: .kosice)

        // Setup updates on distance
        state.$distance
            .debounce(for: 0.5, scheduler: locationQueue)
            .removeDuplicates()
            .combineLatest(locationPublisher)
            .map(repo.churches)
            .receive(on: RunLoop.main)
            .assign(to: \.churches, on: state)
            .store(in: &disposables)

        let distanceInKm = state.$distance
            .map(Int.init(_:))
            .removeDuplicates()

        // Setup date update
        let massesQueue = DispatchQueue(label: "Masses background queue")
        state.$date
            .debounce(for: 0.5, scheduler: massesQueue)
            .combineLatest(locationPublisher, distanceInKm)
            .flatMap {
                self.apiService.masses(
                    date: $0,
                    location: $1,
                    distance: $2
                ).replaceError(with: .empty)
            }
            .map(\.allMasses)
            .map { churchMasses -> [ChurchMasses] in
                churchMasses.compactMap {
                    guard $0.masses.count > 0, let church = self.repo.search(churchId: $0.church) else { return nil }
                    return ChurchMasses(church: church, massesDTO: $0.masses)
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.churchMasses, on: state)
            .store(in: &disposables)
    }

    /// Initialize Home interceptor
    /// - Parameters:
    ///   - state: Init screen state
    ///   - apiService: DoKostola API services
    ///   - repo: Repository services
    ///   - locationManager: Location services
    init(
        state: HomeState,
        apiService: DoKostolaAPIServiceProtocol,
        repo: Repo,
        locationManager: LocationManager = LocationManager()
    ) {
        self.state = state
        self.apiService = apiService
        self.repo = repo
        self.locationManager = locationManager
    }

    // MARK: - Private

    private let apiService: DoKostolaAPIServiceProtocol
    private let repo: Repo
    private let locationManager: LocationManager
    private var disposables = Set<AnyCancellable>()
}
