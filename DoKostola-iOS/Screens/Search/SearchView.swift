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
        Text("Search view")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
