import SwiftUI

struct Screen<Content: View>: View {
    @Environment(\.style) var style: AppStyleProtocol

    var body: some View {
        ZStack {
            style.colors.main.edgesIgnoringSafeArea(edges)
            style.colors.background
            content
        }
    }

    /// Create screen View
    /// - Parameters:
    ///   - edges: Edges of navigation background, for use background color under `Home Indicator` use `[.top, .bottom]` edges
    ///   - content: Screen content
    init(
        edges: Edge.Set = [.top],
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.edges = edges
    }

    /// Content inside element
    private let content: Content
    private let edges: Edge.Set
}

struct Screen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Screen {
                Text("Nah")
            }
        }
    }
}

struct ScreenWithBottomEdge_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Screen(edges: [.top, .bottom]) {
                Text("Nah")
            }
        }
    }
}
