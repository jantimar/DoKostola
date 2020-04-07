import Foundation

/// Info screen interceptro
final class InfoInterceptor {
    /// Info screen state
    let state: InfoState

    /// Setup binding state to services
    func setup() {

    }

    /// Initialize Info interceptor
    /// - Parameter state: Init screen state
    init(state: InfoState) {
        self.state = state
    }
}
