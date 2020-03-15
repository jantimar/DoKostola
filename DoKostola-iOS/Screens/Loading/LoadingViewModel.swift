import Foundation
import Combine

enum LoadingViewModelState {
	case loading
	case finishedLoading
	case error
}

final class LoadingViewModel: ObservableObject {

	@Published var isLoading: Bool = false

	private var state: LoadingViewModelState = .loading {
		didSet { isLoading = state == .loading }
	}

	private let apiService: DoKostolaAPIServiceProtocol
	private let repo: Repo
	private var disposables = Set<AnyCancellable>()

	init(
		apiService: DoKostolaAPIServiceProtocol,
		repo: Repo
	) {
		self.apiService = apiService
		self.repo = repo
		self.setup()
	}

	private func setup() {
		state = .loading

		let churchesPublisher = apiService
			.churches()
			.map(\.churches)
			.map { $0.map(Church.init(churchDTO:)) }

		let feastsPublisher = apiService
			.feasts()
			.map(\.feasts)
			.map { feastsDTO in
				feastsDTO.compactMap { try? Feast(feastDTO: $0) }
		}

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
					self?.state = .finishedLoading
				}
		)
			.store(in: &disposables)
	}
}
