import SwiftUI

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


struct ChatsInfoSheetView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Chats info content will be here")
                .font(.title3)
                .fontWeight(.medium)
        }
        .padding()
        .presentationDetents([.large,])
    }
}
