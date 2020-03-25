//
//  InfoView.swift
//  DoKostola
//
//  Created by Jan Timar on 25/03/2020.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import SwiftUI

struct InfoView: View {

	@ObservedObject var viewModel: InfoViewModel

    var body: some View {
        Text("Info view")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(viewModel: InfoViewModel())
    }
}
