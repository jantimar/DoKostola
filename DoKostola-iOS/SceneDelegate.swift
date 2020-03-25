import UIKit
import SwiftUI
import Combine

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = scene as? UIWindowScene else { return }
		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = UIHostingController(rootView: loadingView)
		self.window = window
		window.makeKeyAndVisible()
	}

	// Properties

	private let repo = Repo()
	private let apiService = DoKostolaAPIService()
	private var disposables = Set<AnyCancellable>()

	private var loadingView: LoadingView {
		let viewModel = LoadingViewModel(
			apiService: apiService,
			repo: repo
		)

		viewModel
			.$isLoading
			.filter { !$0 }
			.sink { [weak self] _ in
				guard let self = self else { return }
				self.window?.rootViewController = UIHostingController(rootView: self.homeView)
		}.store(in: &disposables)

		return LoadingView(viewModel: viewModel)
	}

	private var homeView: HomeView {
		let viewModel = HomeViewModel(
			apiService: apiService,
			repo: repo
		)

		return HomeView(viewModel: viewModel)
	}
}
