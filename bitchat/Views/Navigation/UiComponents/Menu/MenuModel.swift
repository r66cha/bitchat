import SwiftUI

// MARK: - MenuTitles
enum MenuInformationData {
    
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
    
    static let menuButtonLogoImage: String = "ellipsis"
    
    static var menuButtonHeightFrameSize: CGFloat = 44
    static var menuButtonWidthFrameSize: CGFloat = 44
    static var menuButtonFontSize: CGFloat = 20
}


// MARK: - ActionButtons
struct ActionButtons {
    @Binding var showInfoSheet: Bool

    func settingsInfoButton() -> some View {
        Button {
            showInfoSheet = true
        } label: {
            Label(MenuInformationData.settingsMenuInfoTitle,
            systemImage: MenuInformationData.infoImageName)
        }
    }
    
    func chatsInfoButton() -> some View {
        Button {
            showInfoSheet = true
        } label: {
            Label(MenuInformationData.chatsMenuInfoTitle,
            systemImage: MenuInformationData.infoImageName)
        }
    }
}
