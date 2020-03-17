import Foundation
import Combine

final class HomeViewModel: ObservableObject {

	private let apiService: DoKostolaAPIServiceProtocol
	private let locationManager: LocationManager
	private var disposables = Set<AnyCancellable>()

	init(
		apiService: DoKostolaAPIServiceProtocol,
		repo: Repo,
		locationManager: LocationManager = LocationManager()
	) {
		self.apiService = apiService
		self.locationManager = locationManager
		self.setup()
	}

	private func setup() {
		
//		locationManager
//			.publisher
//			.dropFirst(3)
//			.combineLatest(apiService.allCities())
	}
}
