import SwiftUI

struct InjectionContainer {
    var apiService: DoKostolaAPIServiceProtocol
    var repo: Repo
    var locationManager: LocationManager

    var interceptors: InterceptorFactory
}

struct InjectionContainerKey: EnvironmentKey {
    static let defaultValue: InjectionContainer = InjectionContainer(
        apiService: DoKostolaAPIService(),
        repo: .init(),
        locationManager: .init(),
        interceptors: .init()
    )
}

extension EnvironmentValues {
    var injected: InjectionContainer {
        get { self[InjectionContainerKey.self] }
        set { self[InjectionContainerKey.self] = newValue }
    }
}
