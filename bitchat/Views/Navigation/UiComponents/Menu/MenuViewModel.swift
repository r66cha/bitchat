import SwiftUI

struct SettingsMenu: MenuRepresentable {
    @Binding var showInfoSheet: Bool
    var colorScheme: ColorScheme

    var view: AnyView {
        let buttons = ActionButtons(showInfoSheet: $showInfoSheet)
        let menuItems = SettingsMenuItemList(buttons: buttons).menuItemList

        return AnyView(
            Menu {
                ForEach(0..<menuItems.count, id: \.self) { index in
                    let item = menuItems[index]

                    if let title = item.title {
                        title
                    } else if let buttonView = item.viewButton {
                        buttonView
                    }
                }
            } label: {
                ZStack {
                    Image(systemName: MenuInformationData.menuButtonLogoImage)
                        .font(.system(size: MenuInformationData.menuButtonFontSize, weight: .regular))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(width: MenuInformationData.menuButtonWidthFrameSize,
                       height: MenuInformationData.menuButtonHeightFrameSize)
            }
        )
    }
}


struct ChatsMenu: MenuRepresentable {
    @Binding var showInfoSheet: Bool
    var colorScheme: ColorScheme
    
    var view: AnyView {
        let buttons = ActionButtons(showInfoSheet: $showInfoSheet)
        let menuItems = ChatsMenuItemList(buttons: buttons).menuItemList
        
        return AnyView(
            Menu {
                ForEach(0..<menuItems.count, id: \.self) { index in
                    let item = menuItems[index]

                    if let title = item.title {
                        title
                    } else if let buttonView = item.viewButton {
                        buttonView
                    }
                }
            } label: {
                ZStack {
                    Image(systemName: MenuInformationData.menuButtonLogoImage)
                        .font(.system(size: MenuInformationData.menuButtonFontSize, weight: .regular))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(width: MenuInformationData.menuButtonWidthFrameSize,
                       height: MenuInformationData.menuButtonHeightFrameSize)
            }
        )
    }
}


struct AppMenus {
    @Binding var showInfoSheet: Bool
    let colorScheme: ColorScheme
    
    var settingsMenu: some View {
        SettingsMenu(showInfoSheet: $showInfoSheet, colorScheme: colorScheme).view
    }

    var chatsMenu: some View {
        ChatsMenu(showInfoSheet: $showInfoSheet, colorScheme: colorScheme).view
    }
}
