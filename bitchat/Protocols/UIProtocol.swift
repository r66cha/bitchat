//
//  UIProtocol.swift
//  bitchat
//
//  Created by Ruslan Chukavin on 16.07.2025.
//

import SwiftUI

protocol MenuItemRepresentable {
    var isLabel: Bool { get }
    var title: Text { get }
    var imageName: String? { get }
    var action: (() -> Void)? { get }
}

protocol MenuItemListRepresentable {
    var menuItemList: [MenuItemRepresentable] { get }
}
