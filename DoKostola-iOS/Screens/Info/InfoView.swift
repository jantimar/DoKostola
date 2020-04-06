import SwiftUI

struct InfoView: View {

	@ObservedObject var viewModel: InfoViewModel

    var body: some View {
		VStack {
            ForEach(viewModel.texts, id: \.self) {
                Text($0)
                    .padding()
                    .multilineTextAlignment(.center)
            }

			Spacer()
			Button(action: {}) {
				Text("Report bug in feast")
			}.buttonStyle(MainButtonStyle())
			Button(action: {}) {
				Text("Open DoKostola.sk")
			}.buttonStyle(MainButtonStyle())
			Button(action: {}) {
				Text("Contact app author")
			}.buttonStyle(MainButtonStyle())
		}
		.padding()
		.navigationBarTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(viewModel: InfoViewModel())
    }
}
