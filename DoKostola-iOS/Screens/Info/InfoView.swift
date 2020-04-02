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
			}.buttonStyle(DefaultButtonStyle())
			Button(action: {}) {
				Text("Open DoKostola.sk")
			}.buttonStyle(DefaultButtonStyle())
			Button(action: {}) {
				Text("Contact app author")
			}.buttonStyle(DefaultButtonStyle())
		}
		.padding()
		.navigationBarTitle("Info")
    }
}

private struct DefaultButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding()
			.foregroundColor(.white)
			.background(configuration.isPressed ? Color.gray : Color.black)
			.cornerRadius(4)
			.padding()
	}
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(viewModel: InfoViewModel())
    }
}
