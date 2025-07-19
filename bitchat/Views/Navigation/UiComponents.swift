//
//  UiComponents.swift
//  bitchat
//
//  Created by Ruslan Chukavin on 16.07.2025.
//

import SwiftUI

// Views

struct SettingsInfoSheetView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Settings info content will be here")
                .font(.title3)
                .fontWeight(.medium)
        }
        .padding()
        .presentationDetents([.large,])
    }
}

// --

// Enums

enum MenuTitles {
    
    static let localChatMenuLabelTitle: String = "Local chat menu."
    static let mapMenuLabelTitle: String = "Map menu."
    static let peopleMenuLabelTitle: String = "People menu."
    static let chatsMenuLabelTitle: String = "Chats menu."
    static let settingsMenuLabelTitle: String = "Settings menu."
    
    static let localChatMenuInfoTitle: String = "Local chat info"
    static let mapMenuInfoTitle: String = "Map info"
    static let peopleMenuInfoTitle: String = "People info"
    static let chatsMenuInfoTitle: String = "Chats info"
    static let settingsMenuInfoTitle: String = "More info about App"
    
    static let infoImageName: String = "info.circle"
    
}

// --


struct MenuItem: MenuItemRepresentable {
    
    var title: Text?
    var viewButton: AnyView?

    init(title: String) {
        self.title = Text(title)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.gray)
        self.viewButton = nil
    }
    
    init<V: View>(action: V) {
        self.title=nil
        self.viewButton = AnyView(action)
    }
    
}


struct ActionButtons {
    
    @Binding var showSettingsInfoSheet: Bool
    
    func settingsInfoButton() -> some View {
        Button {
            showSettingsInfoSheet = true
        } label: {
            Label(MenuTitles.settingsMenuInfoTitle,
            systemImage: MenuTitles.infoImageName)
        }
    }
}

struct settingsMenuItemList: MenuItemListRepresentable {
    let buttons: ActionButtons
    
    var menuItemList: [any MenuItemRepresentable] {
        [
            MenuItem(title: MenuTitles.settingsMenuLabelTitle),
            MenuItem(action: buttons.settingsInfoButton())
        ]
    }
}


struct SettingsMenu: MenuRepresentable {
    @Binding var showSettingsInfoSheet: Bool
    let colorScheme: ColorScheme
    
    var view: AnyView {
        let buttons = ActionButtons(showSettingsInfoSheet: $showSettingsInfoSheet)
        let menuItems = settingsMenuItemList(buttons: buttons).menuItemList
        
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
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(width: 44, height: 44)
            }
        )
    }
}


struct AppMenus {
    @Binding var showSettingsInfoSheet: Bool
    let colorScheme: ColorScheme
    
    var settingsMenu: some View {
        SettingsMenu(showSettingsInfoSheet: $showSettingsInfoSheet,
                     colorScheme: colorScheme).view
    }
}
