import SwiftUI

struct DetailView: View {

    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                datePicker
                Text(viewModel.churchMasses.church.alias)
                    .multilineTextAlignment(.leading)
                    .padding()
                masses
                Text(viewModel.churchMasses.church.description)
                    .padding()
                Spacer()
                Text(viewModel.address)
                    .padding()
                MapView(annotations: .constant([viewModel.churchMasses.church]))
            }

        }
    }

    private var datePicker: some View {
        DatePicker(
            selection: $viewModel.date,
            in: Date()...,
            displayedComponents: .date
        ) { Text("") }
    }

    private var masses: some View {
        HStack {
            VStack {
                Text("SV. Omše \(DateFormatter.yearMonthDay.string(from: viewModel.date)):")
                ForEach(viewModel.churchMasses.masses, id: \.self) {
                    Text("- \(DateFormatter.hourMinutesSeconds.string(from: $0.time))")
                }
            }
            .multilineTextAlignment(.leading)
            .padding()
            Spacer()
            VStack {
                Button(action: {}) {
                    Text("Navigate to")
                }.buttonStyle(MainButtonStyle())
                Button(action: {}) {
                    Text("DoKostola.sk")
                }.buttonStyle(MainButtonStyle())
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = DetailViewModel(churchMasses: .empty, apiService: DoKostolaAPIService())
//        return DetailView(viewModel: viewModel)
//    }
//}
