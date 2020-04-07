import SwiftUI

struct LoadingView: View {

	@ObservedObject var state: LoadingState
    @Environment(\.injected) var injected: InjectionContainer
    let interceptor: LoadingInterceptor

    var body: some View {
		VStack {
			Text("Loading data...")
			ActivityIndicator(
				isAnimating: state.isLoading,
				style: .large
			)
        }.onAppear(perform: interceptor.setup)
    }
}

#if DEBUG

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let interceptor: LoadingInterceptor = .preview
        return LoadingView(
            state: interceptor.state,
            interceptor: interceptor
        )
    }
}

extension LoadingInterceptor {
    static let preview: LoadingInterceptor = {
        fatalError()
    }()
}

#endif
