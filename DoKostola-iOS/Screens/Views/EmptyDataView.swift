import SwiftUI

enum EmptyDataViewType {
    case text(String)
    case image(String)
    case imageWithText(String, String)

    fileprivate var view: AnyView {
        switch self {
        case let .text(text):
            return AnyView(Text(text))
        case let .image(image):
            return AnyView(Image(image))
        case let .imageWithText(image, text):
            return AnyView(
                VStack {
                    CircleImage(type: .name(image))
                    Text(text)
                }
            )
        }
    }
}

struct EmptyDataView: View {
    let type: EmptyDataViewType
    @Environment(\.style) var style: AppStyleProtocol

    var body: some View {
        HStack {
            Spacer()
            type.view
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
    }
}

struct EmptyViewText_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView(type: .text("No data"))
    }
}

struct EmptyViewImage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView(type: .image("churchPlaceholder"))
    }
}

struct EmptyViewImageWithText_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView(type: .imageWithText("churchPlaceholder", "No data"))
    }
}
