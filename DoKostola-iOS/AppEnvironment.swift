import Foundation
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

struct InterceptorFactory {
    func home(
        state: HomeState = HomeState(),
        apiService: DoKostolaAPIServiceProtocol,
        repo: Repo
    ) -> HomeInterceptor {
        HomeInterceptor(
            state: state,
            apiService: apiService,
            repo: repo
        )
    }

    func loading(
        state: LoadingState = LoadingState(),
        apiService: DoKostolaAPIServiceProtocol,
        repo: Repo
    ) -> LoadingInterceptor {
        LoadingInterceptor(
            state: state,
            apiService: apiService,
            repo: repo
        )
    }

    func searchInterceptor(
        state: SearchState = SearchState(),
        repo: Repo
    ) -> SearchInterceptor {
        SearchInterceptor(state: state, repo: repo)
    }

    func infoInterceptor(
        state: InfoState = InfoState()
    ) -> InfoInterceptor {
        InfoInterceptor(state: InfoState())
    }

    func detail(
        state: DetailState,
        apiService: DoKostolaAPIServiceProtocol
    ) -> DetailInterceptor {
        DetailInterceptor(state: state, apiService: apiService)
    }
}
