import SwiftUI

struct HomeView: View {

	@ObservedObject var state: HomeState
    @Environment(\.injected) var injected: InjectionContainer
    var interceptor: HomeInterceptor

    var body: some View {
		NavigationView {
            VStack {
                datePicker
                MapView(annotations: $state.churches)
                distanceView
                list
            }
			.navigationBarItems(
				leading: infoBarButtons,
				trailing: searchBarButtons
			)
			.navigationBarTitle("DoKostola.sk")
        }.onAppear(perform: interceptor.setup)
    }

    // MARK: - Subviews

    private var list: some View {
        List(state.churchMasses) { value in
            NavigationLink(destination: self.detailView(value)) {
                ChurchMassesRow(value: value)
            }
        }
    }

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
			Text("Near \(state.distance, specifier: "%.0f")")
		}.padding(.horizontal)
	}

	// MARK: - Navigation

    private var infoBarButtons: some View {
        NavigationLink(destination: infoView) {
            Text("Info")
        }
    }

    private var infoView: some View {
        let interceptor = injected
            .interceptors
            .infoInterceptor()
        return InfoView(state: interceptor.state, interceptor: interceptor)
    }

	private var searchBarButtons: some View {
        NavigationLink(destination: searchView) {
			Text("Search")
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

    private func detailView(_ churchMasses: ChurchMasses) -> some View {
        let state = DetailState(churchMasses: churchMasses)
        let interceptor = injected.interceptors.detail(state: state, apiService: injected.apiService)
        return DetailView(state: state, interceptor: interceptor)
    }
}

struct ChurchMassesRow: View {
    var value: ChurchMasses

    var body: some View {
        VStack {
            ForEach(value.masses, id: \.self) { mass in
                HStack {
                    Text(self.value.church.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(DateFormatter.hourMinutesSeconds.string(from: mass.time))
                        .padding()
                        .multilineTextAlignment(.leading)
                }
            }
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
