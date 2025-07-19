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
