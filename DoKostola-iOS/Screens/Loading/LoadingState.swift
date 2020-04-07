import Combine

/// Loading screen state
final class LoadingState: ObservableObject {
	/// Set on `true` when loading is finished or `false` in other case
	@Published var isLoading: Bool = false
}
