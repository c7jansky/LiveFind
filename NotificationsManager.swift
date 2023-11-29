//
//  NotificationsManager.swift
//  LiveFind
//
//  Created by keckuser on 11/28/23.
//
import Foundation

class NotificationsManager {
    static let shared = NotificationsManager()
    private let key = "notifications"

    // Initial data
    private let initialNotifications = [
        NotificationData(title: "Notification 1", description: "Description 1", imageName: "bell.fill"),
        NotificationData(title: "Notification 2", description: "Description 2", imageName: "bell.fill"),
        // Add more initial notifications if needed...
    ]

    init() {
        // Populate with initial data if needed
        if loadNotifications().isEmpty {
            saveNotifications(initialNotifications)
        }
    }

    func saveNotifications(_ notifications: [NotificationData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notifications) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func loadNotifications() -> [NotificationData] {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedNotifications = try? decoder.decode([NotificationData].self, from: savedData) {
                return loadedNotifications
            }
        }
        return []
    }
}

struct NotificationData: Identifiable, Codable {
    let id = UUID()
    var title: String
    var description: String
    var imageName: String
}
