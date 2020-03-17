import SwiftUI
import Combine

struct HomeView: View {

	@ObservedObject var viewModel: HomeViewModel

    var body: some View {
		NavigationView {
			VStack {
				Text("Home")
			}
			.navigationBarItems(
				leading: leadingBarButtons,
				trailing: trialingBarButtons
			)
			.navigationBarTitle("DoKostola.sk")
		}
    }

	private var leadingBarButtons: some View {
		NavigationLink(destination: EmptyView()) {
			Text("Info")
		}
	}
	
	private var trialingBarButtons: some View {
		NavigationLink(destination: EmptyView()) {
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
