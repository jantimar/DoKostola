import SwiftUI

struct SearchView: View {

    @ObservedObject var state: SearchState
    var interceptor: SearchInterceptor

	var body: some View {
		VStack {
			SearchTextField(text: $state.search)
				.frame(height: 40)
				.padding([.trailing, .leading], 16)
			List(state.rows) { row in
				SearchRowView(row: row)
			}
		}
		.navigationBarTitle("Search")
        .onAppear(perform: interceptor.setup)
	}
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//
//		let city = CityDTO(
//			city: "1",
//			title: "city1",
//			lat: "0",
//			lng: "0"
//		)
//		let church = ChurchDTO(
//			church: "church1",
//			title: "church1",
//			city: "city1",
//			lat: "0",
//			lng: "0",
//			desc: "desc",
//			image: nil,
//			thumbnail: nil,
//			alias: "alias"
//		)
//
//		let repo = Repo()
//		repo.churches = [Church(churchDTO: church)]
//		repo.cities = [City(cityDTO: city)]
//
//		let viewModel = SearchViewModel(repo: repo)
//		let view = SearchView(viewModel: viewModel)
//
//		// Search `c`
//		viewModel.search = "c"
//		return view
//    }
//}
