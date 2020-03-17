import SwiftUI
import Combine

struct HomeView: View {

	@ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Text("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		let apiService = DoKostolaAPIService()
		let viewModel = HomeViewModel(apiService: apiService)
		return HomeView(viewModel: viewModel)
    }
}
