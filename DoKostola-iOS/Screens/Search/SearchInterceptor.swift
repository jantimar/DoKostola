import Foundation
import Combine

/// Search screen interceptor
final class SearchInterceptor {
    /// Search screen state
    let state: SearchState

    /// Setup binding state to services
    func setup() {
        // Update search phrase
        let searchQueue = DispatchQueue(label: "Search background queue")
        let searchPublisher = state.$search
            .debounce(for: 0.5, scheduler: searchQueue)
            .removeDuplicates()
            .eraseToAnyPublisher()

        // Search in cities
        let citiesPublisher = searchPublisher
            .map(repo.search(contain:))
            .map { $0.map(SearchRow.city) }
            .eraseToAnyPublisher()

        // Search in churchses
        let churchesPublisher = searchPublisher
            .map(repo.search(contain:))
            .map { $0.map(SearchRow.church) }
            .eraseToAnyPublisher()

        // Combine churches and cities publishers
        citiesPublisher
            .combineLatest(churchesPublisher)
            .map { $0 + $1 }
            .receive(on: RunLoop.main)
            .assign(to: \.rows, on: state)
            .store(in: &disposables)
    }

    /// Initialize Search interceptor
    /// - Parameters:
    ///   - state: Init screen state
    ///   - repo: Repository services
    init(
        state: SearchState,
        repo: Repo
    ) {
        self.state = state
        self.repo = repo
    }

    // MARK: - Private

    private let repo: Repo
    private var disposables = Set<AnyCancellable>()
}
