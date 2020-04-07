import SwiftUI

struct SearchRowView: View {
    let row: SearchRow

    var body: some View {
        switch row {
        case let .church(church):
            return AnyView(ChurchRow(church: church))
        case let .city(city):
            return AnyView(CityRow(city: city))
        case let .text(text):
            return AnyView(Text(text))
        }
    }
}

struct CityRow: View {
    var city: City

    var body: some View {
        Text(city.title)
    }
}

struct ChurchRow: View {
    var church: Church

    var body: some View {
        Text(church.title)
    }
}
