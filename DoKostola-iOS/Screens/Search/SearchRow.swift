import Foundation

enum SearchRow {
    case church(Church)
    case city(City)
    case text(String)
}

extension SearchRow: Identifiable {
    var id: String {
        switch self {
        case let .church(church): return "Church-\(church.id)"
        case let .city(city): return "City-\(city.id)"
        case let .text(text): return "Text-\(text)"
        }
    }
}
