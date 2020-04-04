import Foundation
import Combine

final class DoKostolaAPIService: APIService, DoKostolaAPIServiceProtocol {
    
    // MARK: - DoKostolaAPIServiceProtocol
    
    /// GET all cities
    func cities() -> AnyPublisher<CitiesResponse, APIError> {
        fetch(with: .allCities)
    }
    
    /// GET all churches
    func churches() -> AnyPublisher<ChurchesResponse, APIError> {
        fetch(with: .allChurches)
    }
    
    /// GET all feasts
    func feasts() -> AnyPublisher<FeastsResponse, APIError> {
        fetch(with: .allFeasts)
    }
    
    /// GET masses from specific location
    func masses(
        date: Date,
        location: Location,
        distance: Int
    ) -> AnyPublisher<MassasResponse, APIError> {
        fetch(
            with: .masses(
                location: location,
                time: date,
                distance: distance,
                church: nil
            )
        )
    }
    
    /// GET masses from specific church
    func masses(
        date: Date,
        church: Church,
        distance: Int
    ) -> AnyPublisher<MassasResponse, APIError> {
        fetch(
            with: .masses(
                location: church.location ?? .kosice,
                time: date,
                distance: distance,
                church: church.id
            )
        )
    }
}
