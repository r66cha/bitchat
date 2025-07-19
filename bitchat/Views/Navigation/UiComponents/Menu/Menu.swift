import SwiftUI

class AppMenusModel: ObservableObject {
    @Published var showInfoSheet: Bool = false
    @Published var colorScheme: ColorScheme = .light 

    var appMenus: AppMenus {
        AppMenus(
            showInfoSheet: Binding(
                get: { self.showInfoSheet },
                set: { self.showInfoSheet = $0 }
            ),
            colorScheme: colorScheme
        )
    }
}
