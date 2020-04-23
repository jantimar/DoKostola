import SwiftUI

struct AppStyleKey: EnvironmentKey {
    static let defaultValue: AppStyleProtocol = AppStyle()
}

extension EnvironmentValues {
    var style: AppStyleProtocol {
        get { self[AppStyleKey.self] }
        set { self[AppStyleKey.self] = newValue }
    }
}

protocol AppStyleProtocol {
    var colors: AppColorsProtocol { get }
    var fonts: AppFontsProtocol { get }
}

protocol AppColorsProtocol {
    var main: Color { get }
    var text: Color { get }
    var background: Color { get }
    var buttonsText: Color { get }
}

protocol AppFontsProtocol {
    var title: Font.Weight { get }
    var detail: Font.Weight { get }
}
