import SwiftUI

extension Slider {
    func style(_ style: AppStyleProtocol) -> some View {
        self
            .accentColor(style.colors.main)
    }
}
