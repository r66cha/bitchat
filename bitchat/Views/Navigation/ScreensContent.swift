#if os(iOS)

import SwiftUI
import MapKit

// MARK: - IconsSettings
struct IconsSettings {
    static var labelIconSize: CGFloat = 36
    static var labelIconTextSize: CGFloat = 28
    static var labelIconOpacity: CGFloat = 0.2
}


// MARK: - TabBar
struct BaseScreensNavigation: View {
    @State private var selectedTab = 1
    @StateObject private var viewModel = PeopleScreenViewModel()
    
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
                Label("Chats", systemImage: "bubble.left.and.bubble.right.fill")
            }
            .badge(33)
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

// MARK: - LocalChatScreen
struct LocalChatScreen: View {
    @State private var messageText = ""
    @State private var showSheetView = false
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    
    var body: some View {
        ZStack {
            // Фон, на который вешаем тап
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isTextFieldFocused = false // скрыть клавиатуру
                }
            
            VStack {
                Spacer()
                Text("LocalChat")
                    .font(.body)
                Spacer()
                
                VStack(spacing: 0) {
                    Divider().opacity(0.5)
                    HStack(spacing: 12) {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .light))
                                .foregroundColor(.primary)
                        }
                        .frame(width: 28, height: 28)
                        
                        TextField("Message...", text: $messageText)
                            .focused($isTextFieldFocused)
                            .padding(.horizontal, 8)
                            .frame(height: 28)
                            .background(Color(.systemGray4).opacity(0.5))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.6), lineWidth: 0.5)
                            )
                        
                        Button {
                            messageText = ""
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                }
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .navigationTitle("LocalChat")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    
                    Text("Label")
                    
                    Button {
                    } label: {
                        Label(
                            "Info about Local chat",
                            systemImage: "info.circle")
                    }
                    
                    Button {
                        showSheetView = true
                    } label: {
                        Label(
                            "Button",
                            systemImage: "slider.horizontal.3"
                        )
                    }
                    
                } label: {
                    ZStack {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .frame(width: 44, height: 44)
                }
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showSheetView) {
            SheetView()
        }
        
    }
}

// MARK: - MapScreen
struct MapScreen: View {
    @StateObject private var viewModel = PeopleScreenViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @State private var showSheetView = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $region, annotationItems: viewModel.peopleLocations) { person in
                MapMarker(coordinate: person.coordinate, tint: .green)
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    
                    Text("Label")
                    
                    Button {
                    } label: {
                        Label(
                            "Info about Map",
                            systemImage: "info.circle")
                    }
                    
                    Button {
                        showSheetView = true
                    } label: {
                        Label(
                            "Button",
                            systemImage: "slider.horizontal.3"
                        )
                    }
                    
                } label: {
                    ZStack {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .frame(width: 44, height: 44)
                }
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showSheetView) {
            SheetView()
        }
    }
}

// MARK: - SheetView
struct SheetView: View {
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("Some content will be here")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

// MARK: - NearSheetView
struct NearSheetView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("People around will be here")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

// MARK: - PeopleScreenContent
struct PeopleScreenContent: View {
    @StateObject private var viewModel = PeopleScreenViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @State private var showMapScreen = false
    @State private var showSheetView = false
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.peopleList.isEmpty {
                    Text("No people nearby you")
                } else {
                    List {
                        Section {
                            Text("People nearby you")
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
            
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            UIDevice.current.userInterfaceIdiom == .phone ? viewModel.peopleLabel : ""
        )
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                    showMapScreen = true
                } label: {
                    Image(systemName: "map.fill")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: 44, height: 44)
                }
            }
            
            ToolbarItem(placement: .principal) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(viewModel.peopleLabel)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    
                    Text("Label")
                    
                    Button {
                    } label: {
                        Label(
                            "Info about People",
                            systemImage: "info.circle")
                    }
                    
                    Button {
                        showSheetView = true
                    } label: {
                        Label(
                            "Button",
                            systemImage: "slider.horizontal.3"
                        )
                    }
                    
                    
                } label: {
                    ZStack {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .frame(width: 44, height: 44)
                }
            }
        }
        .navigationDestination(isPresented: $showMapScreen) {
            MapScreen()
        }
        .sheet(isPresented: $showSheetView) {
            SheetView()
        }
    }
}

// MARK: - ChatsScreenContent
struct ChatsScreenContent: View {
    @StateObject private var viewModel = ChatsScreenViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @State private var showLocalChatScreen = false
    @State private var showSheetView = false
    @State private var hasUnreadRequests: Bool = true
    
    var body: some View {
        ZStack {
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            UIDevice.current.userInterfaceIdiom == .phone
            ? viewModel.chatsLabel : ""
        )
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showLocalChatScreen = true
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.green)
                            .frame(width: 44, height: 44)
                        
                        if hasUnreadRequests {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 12, height: 12)
                                .offset(x: -6, y: 6)
                        }
                    }
                    .frame(width: 44, height: 44)
                    //                    .background(Color(.gray)).opacity(0.5)
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
                    
                    Text("Label")
                    
                    Button {
                        
                    } label: {
                        Label(
                            "Info about Chats",
                            systemImage: "info.circle"
                        )
                    }
                    
                    Button {
                        showSheetView = true
                    } label: {
                        Label(
                            "Button",
                            systemImage: "slider.horizontal.3"
                        )
                    }
                    
                    
                    
                } label: {
                    ZStack {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .frame(width: 44, height: 44)
                }
                
            }
        }
        .navigationDestination(isPresented: $showLocalChatScreen) {
            LocalChatScreen()
        }
        .sheet(isPresented: $showSheetView) {
            SheetView()
        }
    }
}

// MARK: - SettingsScreenContent
struct SettingsScreenContent: View {
    @StateObject private var viewModel = SettingsScreenViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @State private var showSettingsInfoSheet = false
    
    var body: some View {
        let menu = AppMenus(showSettingsInfoSheet: $showSettingsInfoSheet, colorScheme: colorScheme)

        ZStack {
            VStack {
                Text(viewModel.settingsData)
            }
        }
        .sheet(isPresented: $showSettingsInfoSheet) {
            SettingsInfoSheetView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                menu.settingsMenu // ← Вот тут красиво вызывается
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // some action
                } label: {
                    Image(systemName: "camera.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 36, weight: .regular))
                        .opacity(0.5)
                        .frame(width: 44, height: 44)
                }
            }

            ToolbarItem(placement: .principal) {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text(viewModel.settingsLabel)
                        .font(.system(size: 20, design: .default).weight(.bold))
                }
            }
        }
    }
}

#endif
