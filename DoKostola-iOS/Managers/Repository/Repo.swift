import Foundation
import Combine

// In-memory database
final class Repo: ObservableObject {

	@Published var cities: [City] = []
	@Published var feasts: [Feast] = []
	@Published var churches: [Church] = []
}
