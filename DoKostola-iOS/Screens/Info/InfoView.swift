import SwiftUI

struct InfoView: View {

    @ObservedObject var state: InfoState
    @Environment(\.injected) var injected: InjectionContainer
    let interceptor: InfoInterceptor

    var body: some View {
		VStack {
            ForEach(state.texts, id: \.self) {
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
        .onAppear(perform: interceptor.setup)
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView(viewModel: InfoViewModel())
//    }
//}
