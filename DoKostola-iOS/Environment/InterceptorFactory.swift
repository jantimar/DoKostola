import Foundation

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
