import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		let repo = Repo()
		let loadingViewModel = LoadingViewModel(
			apiService: DoKostolaAPIService(),
			repo: repo
		)
		let homeView = LoadingView(viewModel: loadingViewModel)

		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
		    window.rootViewController = UIHostingController(rootView: homeView)
		    self.window = window
		    window.makeKeyAndVisible()
		}
	}
}
