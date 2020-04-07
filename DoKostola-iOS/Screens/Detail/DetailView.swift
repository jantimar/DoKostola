import SwiftUI

struct DetailView: View {

    @ObservedObject var state: DetailState
    @Environment(\.injected) var injected: InjectionContainer
    var interceptor: DetailInterceptor

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                datePicker
                Text(state.churchMasses.church.alias)
                    .multilineTextAlignment(.leading)
                    .padding()
                masses
                Text(state.churchMasses.church.description)
                    .padding()
                Spacer()
                Text(state.address)
                    .padding()
                MapView(annotations: .constant([state.churchMasses.church]))
            }
        }
        .onAppear(perform: interceptor.setup)
    }

    private var datePicker: some View {
        DatePicker(
            selection: $state.date,
            in: Date()...,
            displayedComponents: .date
        ) { Text("") }
    }

    private var masses: some View {
        HStack {
            VStack {
                Text("SV. Omše \(DateFormatter.yearMonthDay.string(from: state.date)):")
                ForEach(state.churchMasses.masses, id: \.self) {
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
