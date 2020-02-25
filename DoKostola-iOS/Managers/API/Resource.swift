import Foundation

struct Resource {
	var url: String
	var method: URLMethod = .get
	var path: String = ""
}
