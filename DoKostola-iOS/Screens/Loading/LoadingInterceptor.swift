import Foundation
import Combine

/// Loading screen interceptor
final class LoadingInterceptor {
    /// Loading screen state
    let state: LoadingState

    /// Setup binding state to service
    func setup() {
        state.isLoading = true

        // Fetch churchses
        let churchesPublisher = apiService
            .churches()
            .map(\.churches)
            .map { $0.map(Church.init(churchDTO:)) }

        // Fetch feasts
        let feastsPublisher = apiService
            .feasts()
            .map(\.feasts)
            .map { feastsDTO in
                feastsDTO.compactMap { try? Feast(feastDTO: $0) }
        }

        // Fetch cities
        let citiesPublisher = apiService
            .cities()
            .map(\.cities)
            .map { $0.map(City.init(cityDTO:)) }

        churchesPublisher
            .combineLatest(
                feastsPublisher,
                citiesPublisher
            )
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (churches, feasts, cities) in
                    self?.repo.cities = cities
                    self?.repo.feasts = feasts
                    self?.repo.churches = churches
                    self?.state.isLoading = false
                }
            )
            .store(in: &disposables)
    }

    /// Create new view model and start downlaod all `churches` `cities` and `feasts`
    /// - Parameters:
    ///   - apiService: DoKostola API service
    ///   - repo: In-Memory repository to setup after loading
    init(
        state: LoadingState,
        apiService: DoKostolaAPIServiceProtocol,
        repo: Repo
    ) {
        self.state = state
        self.apiService = apiService
        self.repo = repo
    }

    // MARK: - Private

    private let apiService: DoKostolaAPIServiceProtocol
    private let repo: Repo
    private var disposables = Set<AnyCancellable>()
}
