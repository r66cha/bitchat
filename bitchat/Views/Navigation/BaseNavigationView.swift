//
// BaseNavigationView.swift
// bitchat
//
// This is free and unencumbered software released into the public domain.
// For more information, see <https://unlicense.org>
//

#if os(iOS)
import SwiftUI

// MARK: - BaseNavigationView
// BaseNavigationView provides the main tab-based navigation structure for iOS,
// built with modern UX/UI principles following Apple’s Human Interface Guidelines.
// It uses TabView and NavigationStack to organize the People, Chats, and Settings sections.
// The layout adapts to various device sizes and fully supports both light and dark appearance modes.
struct BaseNavigationView: View {
    var body: some View {
        BaseScreensNavigation()
    }
}
#endif

#Preview {
    BaseNavigationView()
}
