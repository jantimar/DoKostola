import SwiftUI

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.black)
            .cornerRadius(4)
            .padding()
    }
}
