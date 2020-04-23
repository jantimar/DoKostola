import SwiftUI

extension View {
    func style(_ style: AppStyleProtocol) -> some View {
        self
            .background(style.colors.background)
    }
}

extension NavigationView {
    func style(_ style: AppStyleProtocol) -> some View {
        self
            .accentColor(style.colors.buttonsText)
    }
}
