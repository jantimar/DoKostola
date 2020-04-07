import UIKit
import SwiftUI
import Combine

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
    private let container = InjectionContainerKey.defaultValue

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = scene as? UIWindowScene else { return }

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = UIHostingController(
            rootView: loadingView.environment(\.injected, container)
        )
		self.window = window
		window.makeKeyAndVisible()
	}

	// Properties

	private var disposables = Set<AnyCancellable>()

	private var loadingView: LoadingView {
        let interceptor = container.interceptors.loading(
            apiService: container.apiService,
            repo: container.repo
        )

        interceptor.state
			.$isLoading
			.filter { !$0 }
			.sink { [weak self] _ in
				guard let self = self else { return }
				self.window?.rootViewController = UIHostingController(
                    rootView: self.homeView.environment(\.injected, self.container)
                )
		}.store(in: &disposables)
		return LoadingView(
            state: interceptor.state,
            interceptor: interceptor
        )
	}

	private var homeView: HomeView {
        let interceptor = container.interceptors.home(
            apiService: container.apiService,
            repo: container.repo
        )
        return HomeView(
            state: interceptor.state,
            interceptor: interceptor
        )
	}
}
