import SwiftUI
import Combine

struct LoadingView: View {
	@ObservedObject var viewModel: LoadingViewModel

    var body: some View {
		VStack {
			Text("Loading data...")
			ActivityIndicator(
				isAnimating: viewModel.isLoading,
				style: .large
			)
		}
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
		let repo = Repo()
		let apiService = DoKostolaAPIService()

		let viewModel = LoadingViewModel(
			apiService: apiService,
			repo: repo
		)

		return LoadingView(viewModel: viewModel)
    }
}
