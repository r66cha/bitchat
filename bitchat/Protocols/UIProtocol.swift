//
//  UIProtocol.swift
//  bitchat
//
//  Created by Ruslan Chukavin on 16.07.2025.
//

import SwiftUI

protocol MenuItemRepresentable {
    var title: Text? { get }
    var viewButton: AnyView? { get }
}


protocol MenuItemListRepresentable {
    var menuItemList: [MenuItemRepresentable] { get }
}

protocol MenuRepresentable {
    var view: AnyView { get }
}
