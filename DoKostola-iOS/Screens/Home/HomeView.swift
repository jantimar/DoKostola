import SwiftUI
import Combine

struct HomeView: View {

	@ObservedObject var viewModel: HomeViewModel

    var body: some View {
		NavigationView {
            VStack {
                datePicker
                MapView(annotations: $viewModel.churches)
                distanceView
                List(viewModel.churchMasses) {
                    ChurchMassesSection(value: $0)
                }
            }
			.navigationBarItems(
				leading: infoBarButtons,
				trailing: searchBarButtons
			)
			.navigationBarTitle("DoKostola.sk")
		}
    }

    private var datePicker: some View {
        DatePicker(
            selection: $viewModel.date,
            in: Date()...,
            displayedComponents: .date
        ) { Text("") }
    }

	private var distanceView: some View {
		HStack {
			Slider(value: $viewModel.distance, in: 1...50, step: 1)
			Text("Near \(viewModel.distance, specifier: "%.0f")")
		}.padding(.horizontal)
	}

	// MARK: - Navigation

	private var infoBarButtons: some View {
		NavigationLink(
			destination: InfoView(viewModel: viewModel.infoViewModel)
		) {
			Text("Info")
		}
	}

	private var searchBarButtons: some View {
		NavigationLink(
			destination: SearchView(viewModel: viewModel.searchViewModel)
		) {
			Text("Search")
		}
	}
}

struct ChurchMassesSection: View {
    var value: ChurchMasses

    var body: some View {
        VStack {
            ForEach(value.masses, id: \.self) { mass in
                HStack {
                    Text(self.value.church.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(DateFormatter.hourMinutesSeconds.string(from: mass.time))
                        .padding()
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		let apiService = DoKostolaAPIService()
		let viewModel = HomeViewModel(apiService: apiService, repo: Repo())
		return HomeView(viewModel: viewModel)
    }
}
