import SwiftUI
import Combine

struct HomeView: View {

	@ObservedObject var viewModel: HomeViewModel

    var body: some View {
		NavigationView {
			VStack {
				MapView(annotations: $viewModel.churches)
				Slider(value: $viewModel.distance, in: 1...50, step: 1)
				List(viewModel.churches) { church in
					ChurchRow(church: church)
				}
			}
			.navigationBarItems(
				leading: infoBarButtons,
				trailing: searchBarButtons
			)
			.navigationBarTitle("DoKostola.sk")
		}
    }

	// MARK: - Navigation

	private var infoBarButtons: some View {
		NavigationLink(
			destination: InfoView(viewModel: viewModel.infoViewModel)
		) {
			Text("Info")
		}
	}

	private var searchBarButtons: some View {
		NavigationLink(
			destination: SearchView(viewModel: viewModel.searchViewModel)
		) {
			Text("Search")
		}
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		let apiService = DoKostolaAPIService()
		let viewModel = HomeViewModel(apiService: apiService, repo: Repo())
		return HomeView(viewModel: viewModel)
    }
}
