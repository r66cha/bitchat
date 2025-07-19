//
//  MenuItemConfiguration.swift
//  bitchat
//
//  Created by Ruslan Chukavin on 19.07.2025.
//

import SwiftUI


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

struct SettingsMenuItemList: MenuItemListRepresentable {
    let buttons: ActionButtons
    
    var menuItemList: [any MenuItemRepresentable] {
        [
            MenuItem(title: MenuInformationData.settingsMenuLabelTitle),
            MenuItem(action: buttons.settingsInfoButton())
        ]
    }
}


struct ChatsMenuItemList: MenuItemListRepresentable {
    let buttons: ActionButtons
    
    var menuItemList: [any MenuItemRepresentable] {
        [
            MenuItem(title: MenuInformationData.chatsMenuLabelTitle),
            MenuItem(action: buttons.chatsInfoButton())
        ]
    }
}
