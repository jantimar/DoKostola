import SwiftUI

struct HomeView: View {

	@ObservedObject var state: HomeState
    @Environment(\.injected) var injected: InjectionContainer
    @Environment(\.style) var style: AppStyleProtocol
    var interceptor: HomeInterceptor

    var body: some View {
        NavigationView {
            Screen {
                VStack {
                    // datePicker
                    MapView(annotations: $state.churches)
                    distanceView
                    MassesList(values: state.churchMasses)
                }
                .navigationBarItems(
                    leading: InfoButtons(),
                    trailing: SearchButtons()
                )
                .style(style)
            }
            .navigationBarTitle("DoKostola.sk")
        }
        .style(style)
        .onAppear(perform: interceptor.setup)
    }

    // MARK: - Subviews

    private var datePicker: some View {
        DatePicker(
            selection: $state.date,
            in: Date()...,
            displayedComponents: .date
        ) { Text("") }
    }

    private var distanceView: some View {
        HStack {
            Slider(value: $state.distance, in: 1...50, step: 1)
                .style(style)
            Text("Near \(state.distance, specifier: "%.0f")")
        }.padding(.horizontal)
    }

    // MARK: - Masses list

    private struct MassesList: View {
        let values: [ChurchMasses]
        @Environment(\.injected) var injected: InjectionContainer

        var body: some View {
            List(values) { value in
                NavigationLink(destination: self.detailView(value)) {
                    ChurchMassesRow(value: value)
                }
            }
            .listStyle(GroupedListStyle())
        }

        private func detailView(_ value: ChurchMasses) -> some View {
            let state = DetailState(churchMasses: value)
            let interceptor = injected.interceptors.detail(state: state, apiService: injected.apiService)
            return DetailView(state: state, interceptor: interceptor)
        }
    }

	// MARK: - Navigation

    private struct InfoButtons: View {
        @Environment(\.injected) var injected: InjectionContainer

        var body: some View {
            NavigationLink(destination: infoView) {
                Image("info")
            }
        }

        private var infoView: some View {
            let interceptor = injected
                .interceptors
                .infoInterceptor()
            return InfoView(state: interceptor.state, interceptor: interceptor)
        }
    }

    private struct SearchButtons: View {
        @Environment(\.injected) var injected: InjectionContainer

        var body: some View {
            NavigationLink(destination: searchView) {
                Image("search")
            }
        }

        private var searchView: some View {
            let interceptor = injected
                .interceptors
                .searchInterceptor(repo: injected.repo)
            return SearchView(
                state: interceptor.state,
                interceptor: interceptor
            )
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//		let apiService = DoKostolaAPIService()
//		let viewModel = HomeViewModel(apiService: apiService, repo: Repo())
//		return HomeView(viewModel: viewModel)
//    }
//}
