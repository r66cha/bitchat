#if os(iOS)
import SwiftUI

struct IconsSettings {
    static var labelIconSize: CGFloat = 36
    static var labelIconTextSize: CGFloat = 28
    static var labelIconOpacity: CGFloat = 0.2
    
}

// MARK: - TabBar
// TabBar and main navigation buttons
struct BaseScreensNavigation: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                PeopleScreenContent()
            }
            .tabItem {
                Label("People", systemImage: "person.2.fill")
            }
            .tag(0)
            
            NavigationStack {
                ChatsScreenContent()
            }
            .tabItem {
                Label(
                    "Chats",
                    systemImage: "bubble.left.and.bubble.right.fill"
                )
            }
            .tag(1)
            
            NavigationStack {
                SettingsScreenContent()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(2)
            
        }
        .tint(.green)
    }
}


struct RequestsScreen: View {
    var body: some View {
        VStack {
            Text("Requests for conversations")
                .font(.body)
        }
        .navigationTitle("Requests")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MetsScreen: View {
    var body: some View {
        VStack {
            Text("Met people today")
                .font(.body)
        }
        .navigationTitle("Met")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QRCodeSheetView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Здесь будет ваш QR-код")
                .font(.title3)
                .fontWeight(.medium)
        }
        .padding()
        .presentationDetents([.medium, .large]) // iOS 16+ детенты
    }
}



// MARK: - PeopleScreenContent
// People screen with adaptive navigation title and MVVM pattern
struct PeopleScreenContent: View {
    @StateObject private var viewModel = PeopleScreenViewModel()
    @State private var isBookmarked: Bool = false
    @State private var showMetsScreen = false
    
    var body: some View {
        VStack {
            if viewModel.peopleList.isEmpty {
                Text("No people nearby you")
            } else {
                List {
                    
                    Section {
                        Text("People around you")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .listRowSeparator(.hidden)
                    
                    ForEach(viewModel.peopleList, id: \.self) { person in
                        UserBoxView(username: person)
                    }
                    .font(.body)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            UIDevice.current.userInterfaceIdiom == .phone
            ? viewModel.peopleLabel : ""
        )
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showMetsScreen = true
                } label: {
                    ZStack {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.green)
                    }
                    .font(.system(.title, design: .default).weight(.bold))
                    //                    .background(Color.gray.opacity(0.2))
                }
            }
            
            ToolbarItem(placement: .principal) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(viewModel.peopleLabel)
                        .font(
                            .system(size: 20, design: .default).weight(
                                .bold
                            )
                        )
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isBookmarked.toggle()
                } label: {
                    ZStack {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(
                                isBookmarked ? .green : .gray.opacity(0.5)
                            )
                    }
                    .frame(width: 44, height: 44)
                    //                    .background(Color.gray.opacity(0.2))
                }
            }
        }
        .navigationDestination(isPresented: $showMetsScreen) {
            MetsScreen()
        }
    }
}


// MARK: - ChatsScreenContent
// Chats screen with adaptive navigation title and MVVM pattern
struct ChatsScreenContent: View {
    @StateObject private var viewModel = ChatsScreenViewModel()
    @State private var showRequestsScreen = false

    var body: some View {
        VStack {
            if viewModel.chatList.isEmpty {
                List {
                    Text(viewModel.multiChat)
                        .font(.body)
                }
            } else {
                List {
                    Section {
                        Text("All your conversations")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .listRowSeparator(.hidden)
                    
                    Text(viewModel.multiChat)
                        .font(.body)
                    
                    ForEach(viewModel.chatList) { chat in
                        ChatBoxView(
                            username: chat.username,
                            lastMessage: chat.lastMessage,
                            hour: chat.hour,
                            minute: chat.minute,
                            isRead: chat.isRead,
                            isDelivered: chat.isDelivered
                        )
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            UIDevice.current.userInterfaceIdiom == .phone
            ? viewModel.chatsLabel : ""
        )
        .toolbar {
            // Левая кнопка — переход на InfoScreen
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showRequestsScreen = true
                } label: {
                    ZStack {
                        Image(systemName: "exclamationmark.bubble")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.green)
                    }
                    .frame(width: 44, height: 44)
                }
            }

            ToolbarItem(placement: .principal) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(viewModel.chatsLabel)
                        .font(.system(size: 20, weight: .bold))
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        // TODO: Create channel
                    } label: {
                        Label("Create Channel", systemImage: "plus.message.fill")
                    }

                    Button {
                        // TODO: Join channel
                    } label: {
                        Label("Join Channel", systemImage: "link")
                    }
                } label: {
                    ZStack {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.green)
                    }
                    .frame(width: 44, height: 44)
                }
            }
        }
        .navigationDestination(isPresented: $showRequestsScreen) {
            RequestsScreen()
        }
    }
}

// MARK: - SettingsScreenContent
// Settings screen with adaptive navigation title and MVVM pattern
struct SettingsScreenContent: View {
    @StateObject private var viewModel = SettingsScreenViewModel()
    @State private var showQRCodeSheet = false
    
    // Main content of the SettingsScreen
    var body: some View {
        VStack {
            Text(viewModel.settingsData)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            UIDevice.current.userInterfaceIdiom == .phone
            ? viewModel.settingsLabel : ""
        )
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                                showQRCodeSheet = true
                            }
                } label: {
                    ZStack {
                        Image(systemName: "qrcode")
                            .font(.system(size: 20, weight: .medium))
                            .frame(
                                width: IconsSettings.labelIconSize,
                                height: IconsSettings.labelIconSize
                            )
                    }
                    .frame(width: 44, height: 44)
                    //                    .background(Color.gray.opacity(0.2))
                    
                }
            }
            
            ToolbarItem(placement: .principal) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(viewModel.settingsLabel)
                        .font(
                            .system(size: 20, design: .default).weight(
                                .bold
                            )
                        )
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // tap button logic
                } label: {
                    ZStack {
                        //                        Circle()
                        //                            .stroke(Color.gray, lineWidth: 2)
                        //                            .frame(width: 44, height: 44)
                        
                        Image(systemName: "camera.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 36, weight: .regular))
                            .opacity(0.5)
                    }
                    .frame(width: 44, height: 44)
                    //                    .background(Color.gray.opacity(0.2))
                }
            }
        }
        .sheet(isPresented: $showQRCodeSheet) {
            QRCodeSheetView()
        }
    }
}
#endif
