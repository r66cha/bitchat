import SwiftUI

class AppMenusModel: ObservableObject {
    @Published var showInfoSheet: Bool = false

    func appMenus(for colorScheme: ColorScheme) -> AppMenus {
        AppMenus(
            showInfoSheet: Binding(
                get: { self.showInfoSheet },
                set: { self.showInfoSheet = $0 }
            ),
            colorScheme: colorScheme
        )
    }
}
