//
//  UiComponents.swift
//  bitchat
//
//  Created by Ruslan Chukavin on 16.07.2025.
//

import SwiftUI

struct MenuItem: MenuItemRepresentable {
    @Environment(\.colorScheme) private var colorScheme
    
    var isLabel: Bool { false }
    var title: Text
    var imageName: String?
    var action: (() -> Void)?
    
    init(isLabel: Bool,
         title: String,
         imageName: String? = nil,
         action: (() -> Void)? = nil) {
        
        self.title = Text(title)
            .font(.system(size: isLabel == true ? 12 : 14, weight: .regular))
            .foregroundColor(isLabel == true ? .gray : colorScheme == .dark ? .white : .black)
        self.imageName = imageName
        self.action = action
        
    }
}

struct menuTitles {
    
    let localChatMenuLabelTitle: String = "Local chat menu."
    let mapMenuLabelTitle: String = "Map menu."
    let peopleMenuLabelTitle: String = "People menu."
    let chatsMenuLabelTitle: String = "Chats menu."
    let settingsMenuLabelTitle: String = "Settings menu."
    
    let localChatMenuInfoTitle: String = "Local chat info"
    let mapMenuInfoTitle: String = "Map info"
    let peopleMenuInfoTitle: String = "People info"
    let chatsMenuInfoTitle: String = "Chats info"
    let settingsMenuInfoTitle: String = "More info about App"
    
    let infoInageName: String = "info.circle"
    
    
    

    
    
}

struct settingsMenuItemList: MenuItemListRepresentable {
    
    var menuItemList: [any MenuItemRepresentable] = [
        MenuItem(title: "Settings menu"),
        MenuItem(title: "Info about APP",
                 imageName: "info.circle",
                 action: { print("Action") } )
    ]
}
