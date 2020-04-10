import SwiftUI

extension Text {
    func title(_ style: AppStyleProtocol) -> some View {
        self
            .foregroundColor(style.colors.main)
            .fontWeight(style.fonts.title)
    }

    func detail(_ style: AppStyleProtocol) -> some View {
        self
            .foregroundColor(style.colors.text)
            .fontWeight(style.fonts.detail)
    }
}
