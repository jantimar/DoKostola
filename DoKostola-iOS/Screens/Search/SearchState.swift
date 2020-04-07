import Combine

/// Search screen state
final class SearchState: ObservableObject {
    /// Search phrase
    @Published var search = ""
    /// Rows of `cities` = `churches` result base on `search`
    @Published var rows = [SearchRow]()
}
