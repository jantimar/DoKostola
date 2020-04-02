import Foundation
import Combine

enum SearchRow {
	case church(Church)
	case city(City)
	case text(String)
}

extension SearchRow: Identifiable {
	var id: String {
		switch self {
		case let .church(church): return "Church-\(church.id)"
		case let .city(city): return "City-\(city.id)"
		case let .text(text): return "Text-\(text)"
		}
	}
}

final class SearchViewModel: ObservableObject {

	/// Search phrase
	@Published var search = ""
	/// Rows of `cities` = `churches` result base on `search`
	@Published var rows = [SearchRow]()

	init(
		repo: Repo
	) {
		self.repo = repo
		setup()
	}

	// MARK: - Private

	private let repo: Repo
	private var disposables = Set<AnyCancellable>()

	private func setup() {
		let searchQueue = DispatchQueue(label: "Search background queue")
		let searchPublisher = $search
			.debounce(for: 0.5, scheduler: searchQueue)
			.removeDuplicates()
			.eraseToAnyPublisher()

		let citiesPublisher = searchPublisher
			.map(repo.search(_:))
			.map { $0.map(SearchRow.city) }
			.eraseToAnyPublisher()

		let churchesPublisher = searchPublisher
			.map(repo.search(_:))
			.map { $0.map(SearchRow.church) }
			.eraseToAnyPublisher()

		citiesPublisher
			.combineLatest(churchesPublisher)
			.map { $0 + $1 }
			.receive(on: RunLoop.main)
			.assign(to: \.rows, on: self)
			.store(in: &disposables)
	}
}
