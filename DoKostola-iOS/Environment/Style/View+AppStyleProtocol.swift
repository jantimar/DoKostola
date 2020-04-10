import SwiftUI

extension View {
    func style(_ style: AppStyleProtocol) -> some View {
        self
            .background(style.colors.background)
    }
}
