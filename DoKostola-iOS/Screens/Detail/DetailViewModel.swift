import Foundation
import CoreLocation
import Combine

final class DetailViewModel: ObservableObject {

    @Published var date = Date()

    @Published var churchMasses: ChurchMasses

    @Published var address = ""

    init(
        churchMasses: ChurchMasses,
        apiService: DoKostolaAPIServiceProtocol,
        geocoder: Geocoder = .init()
    ) {
        self.churchMasses = churchMasses
        self.apiService = apiService
        self.geocoder = geocoder

        setup()
    }

    // MARK: - Private

    private let apiService: DoKostolaAPIServiceProtocol
    private let geocoder: Geocoder
    private var disposables = Set<AnyCancellable>()

    private func setup() {

        let massesQueue = DispatchQueue(label: "Masses background queue")
        $date
            .debounce(for: 0.5, scheduler: massesQueue)
            .flatMap {
                self.apiService.masses(
                    date: $0,
                    church: self.churchMasses.church
                ).replaceError(with: .empty)
            }
            .map(\.allMasses)
            .map {
                ChurchMasses(
                    church: self.churchMasses.church,
                    massesDTO: $0.first?.masses ?? []
                )
            }
            .receive(on: RunLoop.main)
            .assign(to: \.churchMasses, on: self)
            .store(in: &disposables)

        geocoder
            .reverseGeocode(location: churchMasses.church.location ?? .kosice)
            .map { placemark in
                [placemark.locality, placemark.thoroughfare]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            .replaceError(with: "")
            .receive(on: RunLoop.main)
            .assign(to: \.address, on: self)
            .store(in: &disposables)
    }
}
