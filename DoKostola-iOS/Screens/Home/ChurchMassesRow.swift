import SwiftUI

struct ChurchMassesRow: View {
    @Environment(\.style) var style: AppStyleProtocol
    var value: ChurchMasses

    var body: some View {
        VStack {
            ForEach(value.masses, id: \.self) { mass in
                HStack {
                    CircleImage(type: .name("churchPlaceholder"))
                    Text(self.value.church.title)
                        .title(self.style)
                    Spacer()
                    Text(DateFormatter.hourMinutes.string(from: mass.time))
                        .detail(self.style)
                }
                .multilineTextAlignment(.leading)
            }
        }
    }
}

// MARK: - Preview

struct ChurchMassesRow_Previews: PreviewProvider {
    static var previews: some View {
        ChurchMassesRow(value: .mock)
            .environment(\.colorScheme, .light)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}

struct ChurchMassesRow_Dark_Previews: PreviewProvider {
    static var previews: some View {
        ChurchMassesRow(value: .mock)
            .environment(\.colorScheme, .dark)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}

private extension ChurchMasses {
    static let mock = ChurchMasses(
        church: Church(
            churchDTO: ChurchDTO(
                church: "",
                title: "Bratislava - mestska cast Stare Mesto",
                city: "",
                lat: "48.143557",
                lng: "17.108424",
                desc: "",
                image: nil,
                thumbnail: nil,
                alias: ""
            )
        ),
        massesDTO: [
            MassDTO(
                church: "church_id",
                date: "1970-01-01",
                time: "11:12:30",
                note: "Note"
            )
    ])
}
