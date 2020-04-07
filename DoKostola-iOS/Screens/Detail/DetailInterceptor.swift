import Foundation
import Combine

/// Detail screen interceptor
final class DetailInterceptor {
    /// Detail screen state
    let state: DetailState

    /// Setup binding state to services
    func setup() {
        // Fetch masses
        let massesQueue = DispatchQueue(label: "Masses background queue")
        state.$date
            .debounce(for: 0.5, scheduler: massesQueue)
            .flatMap {
                self.apiService.masses(
                    date: $0,
                    church: self.state.churchMasses.church
                ).replaceError(with: .empty)
        }
        .map(\.allMasses)
        .map {
            ChurchMasses(
                church: self.state.churchMasses.church,
                massesDTO: $0.first?.masses ?? []
            )
        }
        .receive(on: RunLoop.main)
        .assign(to: \.churchMasses, on: state)
        .store(in: &disposables)

        // Fetch name for current location
        geocoder
            .reverseGeocode(location: state.churchMasses.church.location ?? .kosice)
            .map { placemark in
                [placemark.locality, placemark.thoroughfare]
                    .compactMap { $0 }
                    .joined(separator: ", ")
        }
        .replaceError(with: "")
        .receive(on: RunLoop.main)
        .assign(to: \.address, on: state)
        .store(in: &disposables)
    }

    /// Initialize Detail screen interceptor
    /// - Parameters:
    ///   - state: Init screen state
    ///   - apiService: DoKostolaAPI services
    ///   - geocoder: Geocoder services
    init(
        state: DetailState,
        apiService: DoKostolaAPIServiceProtocol,
        geocoder: Geocoder = .init()
    ) {
        self.state = state
        self.apiService = apiService
        self.geocoder = geocoder
    }

    // MARK: - Private

    private let apiService: DoKostolaAPIServiceProtocol
    private let geocoder: Geocoder
    private var disposables = Set<AnyCancellable>()
}
