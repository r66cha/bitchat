#if os(iOS)
import SwiftUI
import MapKit

struct PersonLocation: Identifiable {
    let id = UUID()
    let username: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - UserBoxView
struct UserBoxView: View {
    let username: String
    
    var body: some View {
        VStack(spacing: 0) {
            Button {} label: {
                HStack(spacing: 12) {
                    // Круглая системная иконка профиля
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                    
                    Text(username)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            
        }
    }
}

// MARK: - ChatBoxView
struct ChatBoxView: View {
    let username: String
    let lastMessage: String
    let hour: Int
    let minute: Int
    let isRead: Bool
    let isDelivered: Bool
    
    var formattedTime: String {
        String(format: "%02d:%02d", hour, minute)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button {} label: {
                HStack(spacing: 12) {
                    // Аватар
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                    
                    // Имя и последнее сообщение
                    VStack(alignment: .leading, spacing: 4) {
                        Text(username)
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text(lastMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Время и статус
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(formattedTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: -8) {
                            Image(systemName: "checkmark")
                            
                            if isRead {
                                Image(systemName: "checkmark")
                            }
                        }
                        .font(.caption2)
                        .foregroundColor(isRead ? .green : .gray)
                    }
                }
                //            .padding(.horizontal)
                //            .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - ChatModel
struct ChatModel: Identifiable, Hashable {
    let id = UUID()
    let username: String
    let lastMessage: String
    let hour: Int
    let minute: Int
    let isRead: Bool
    let isDelivered: Bool
}

// MARK: - PeopleScreenViewModel
class PeopleScreenViewModel: ObservableObject {
    @Published var peopleList: [String] = []
    let peopleLabel: String = "People"
    
    @Published var peopleLocations: [PersonLocation] = [
        .init(username: "User 1", coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)),
        .init(username: "User 2", coordinate: CLLocationCoordinate2D(latitude: 55.760000, longitude: 37.620000)),
        .init(username: "User 3", coordinate: CLLocationCoordinate2D(latitude: 55.748000, longitude: 37.615000)),
    ]
    
    init() {
        loadPeople()
    }
    
    func loadPeople() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.peopleList = (1...20).map {"User\($0)"} /*[]*/
        }
    }
}

// MARK: - ChatsScreenViewModel
class ChatsScreenViewModel: ObservableObject {
    @Published var chatList: [ChatModel] = []
    let multiChat: String = "Multichat"
    let chatsLabel: String = "Chats"
    
    init() {
        loadChats()
    }
    
    func loadChats() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.chatList = (1...20).map {
                ChatModel(
                    username: "User\($0)",
                    lastMessage: "Last message from User\($0)",
                    hour: 14,
                    minute: $0,
                    isRead: $0 % 3 == 0,
                    isDelivered: $0 % 2 == 0
                )
            }
        }
    }
}

// MARK: - SettingsScreenViewModel
class SettingsScreenViewModel: ObservableObject {
    // Logic and data for SettingsScreen will be here
    
    @Published var settings: [String] = []
    let settingsData: String = "Settings data"
    let settingsLabel: String = "Settings"
}
#endif
