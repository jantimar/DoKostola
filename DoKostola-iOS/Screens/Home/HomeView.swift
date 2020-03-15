import SwiftUI
import Combine

struct HomeView: View {

	@ObservedObject var viewModel: HomeViewModel

	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
	}

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		let apiService = DoKostolaAPIService()
		let viewModel = HomeViewModel(apiService: apiService)
		return HomeView(viewModel: viewModel)
    }
}
