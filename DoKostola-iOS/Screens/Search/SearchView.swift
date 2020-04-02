//
//  SearchView.swift
//  DoKostola
//
//  Created by Jan Timar on 25/03/2020.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import SwiftUI

struct SearchView: View {

	@ObservedObject var viewModel: SearchViewModel

	var body: some View {
		VStack {
			SearchTextField(text: $viewModel.search)
				.frame(height: 40)
				.padding([.trailing, .leading], 16)
			List(viewModel.rows) { row in
				SearchRowView(row: row)
			}
		}
		.navigationBarTitle("Search")
	}
}

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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {

		let city = CityDTO(
			city: "1",
			title: "city1",
			lat: "0",
			lng: "0"
		)
		let church = ChurchDTO(
			church: "church1",
			title: "church1",
			city: "city1",
			lat: "0",
			lng: "0",
			desc: "desc",
			image: nil,
			thumbnail: nil,
			alias: "alias"
		)

		let repo = Repo()
		repo.churches = [Church(churchDTO: church)]
		repo.cities = [City(cityDTO: city)]

		let viewModel = SearchViewModel(repo: repo)
		let view = SearchView(viewModel: viewModel)

		// Search `c`
		viewModel.search = "c"
		return view
    }
}
