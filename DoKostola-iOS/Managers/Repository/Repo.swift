import Foundation
import Combine

// In-memory database
final class Repo: ObservableObject {

	@Published var cities: [City] = []
	@Published var feasts: [Feast] = []
	@Published var churches: [Church] = []

	func search(_ text: String) -> [City] {
		cities.filter { $0.title.contains(text) }
	}

	func search(_ text: String) -> [Church] {
		churches.filter { $0.title.contains(text) }
	}
}
