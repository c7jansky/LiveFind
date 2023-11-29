//
//  NotificationsView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

//For the API data:

//struct NotificationsView: View {
//    let Primary = Color("PrimaryColor")
//    let Secondary = Color("SecondaryColor")
//
//    // Create a model for API data
//    struct NotificationData {
//        let title: String
//        let description: String
//        let imageName: String
//    }
//
//    // Use @State or @ObservedObject to manage API data
//    @State private var apiData: [NotificationData] = []
//
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
//                                                                    UIColor.init(Secondary)]
//
//        // Fetch API data here and populate the apiData array
//        fetchDataFromAPI()
//    }
//
//    func fetchDataFromAPI() {
//        // Use URLSession or a networking library to fetch data from the API
//        // Process the API response and populate the apiData array
//    }
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    ForEach(apiData, id: \.self) { data in
//                        NotificationItemView(
//                            title: data.title,
//                            description: data.description,
//                            imageName: data.imageName
//                        )
//                        .foregroundColor(Secondary)
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle("Notifications")
//        }
//        .environment(\.colorScheme, .dark)
//        .ignoresSafeArea()
//    }
//}
//
//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
//}

//let descriptions = [
//    "There are 30 days remaining before your concert is to start",
//    "There are 10 days remaining before your concert is to start",
//    "Your Concert is happening tonight!! Get Hyped!",
//    "This liked artist is having a live event soon. Click to see details"
//]

struct NotificationsView: View {
    @State private var notifications: [NotificationData] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(notifications) { notification in
                    NotificationItemView(notification: notification)
                }
                .onDelete(perform: deleteNotification)
            }
            .navigationBarTitle("Notifications")
        }
        .onAppear {
            notifications = NotificationsManager.shared.loadNotifications()
        }
    }

    private func deleteNotification(at offsets: IndexSet) {
        notifications.remove(atOffsets: offsets)
        NotificationsManager.shared.saveNotifications(notifications)
    }
    
    func addNotification(title: String, description: String, imageName: String) {
            let newNotification = NotificationData(title: title, description: description, imageName: imageName)
            notifications.append(newNotification)
            NotificationsManager.shared.saveNotifications(notifications)
    }
}

struct NotificationItemView: View {
    let Secondary = Color("SecondaryColor")
    var notification: NotificationData
    
    var body: some View {
        HStack {
            Image(systemName: notification.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(Secondary)
                .padding()

            VStack(alignment: .leading) {
                Text(notification.title)
                    .foregroundColor(Secondary)
                    .font(.headline)
                Text(notification.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
