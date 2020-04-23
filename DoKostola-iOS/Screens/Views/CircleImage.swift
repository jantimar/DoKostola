import SwiftUI

enum CircleImageType {
    case name(String)
    case image(Image)
    case uiImage(UIImage)

    var image: Image {
        switch self {
        case let .image(image): return image
        case let .name(name): return Image(name)
        case let .uiImage(uiImage): return Image(uiImage: uiImage)
        }
    }
}

struct CircleImage: View {
    @Environment(\.style) var style: AppStyleProtocol

    var type: CircleImageType

    var body: some View {
        type.image
            .resizable()
            .frame(width: 25, height: 25)
            .padding()
            .overlay(
                Circle().stroke(style.colors.main, lineWidth: 1)
            )
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage(type: .name("churchPlaceholder"))
            CircleImage(type: .image(Image("churchPlaceholder")))
            CircleImage(type: .uiImage(UIImage(named: "churchPlaceholder")!))
        }
        .environment(\.colorScheme, .light)
        .environment(\.style, AppStyleKey.defaultValue)
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

struct CircleImage_Dark_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CircleImage(type: .name("churchPlaceholder"))
            CircleImage(type: .image(Image("churchPlaceholder")))
            CircleImage(type: .uiImage(UIImage(named: "churchPlaceholder")!))
        }
        .environment(\.colorScheme, .dark)
        .environment(\.style, AppStyleKey.defaultValue)
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
