//
//  NotificationsView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//
import SwiftUI

import SwiftUI

struct NotificationItemView: View {
    let title: String
    let description: String
    let imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

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


struct NotificationsView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")

    // Define arrays for different scenarios
    let titles = ["Notification 1", "Notification 2", "Notification 3", "Liked Artist"]
    let descriptions = [
        "There are 30 days remaining before your concert is to start",
        "There are 10 days remaining before your concert is to start",
        "Your Concert is happening tonight!! Get Hyped!",
        "This liked artist is having a live event soon. Click to see details"
    ]
    let imageNames = ["bell.fill", "bell.fill", "bell.fill", "heart.fill"]

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0..<4) { index in
                        NotificationItemView(
                            title: titles[index],
                            description: descriptions[index],
                            imageName: imageNames[index]
                        )
                        .foregroundColor(Secondary)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Notifications")
        }
        .environment(\.colorScheme, .dark)
        .ignoresSafeArea()
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
