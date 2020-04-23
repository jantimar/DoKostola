import SwiftUI

struct AppStyle: AppStyleProtocol {
    let colors: AppColorsProtocol
    let fonts: AppFontsProtocol

    init(
        colors: AppColorsProtocol = AppColors(),
        fonts: AppFontsProtocol = AppFonts()
    ) {
        self.colors = colors
        self.fonts = fonts
        setupApperance()
    }

    private func setupApperance() {
        UITableViewCell.appearance().selectionStyle = .none

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

struct AppColors: AppColorsProtocol {
    let main = Color("main")
    let text = Color("text")
    let background = Color("background")
    let buttonsText: Color = .white
}

struct AppFonts: AppFontsProtocol {
    let title: Font.Weight = .bold
    let detail: Font.Weight = .regular
}
