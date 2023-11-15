//
//  notificationData.swift
//  LiveFind
//
//  Created by keckuser on 11/15/23.
//

import Foundation

struct NotificationItem {
    let title: String
    let description: String
    let imageName: String
}

let notificationData: [NotificationItem] = [
    NotificationItem(title: "Notification 1", description: "Description 1", imageName: "bell.fill"),
    NotificationItem(title: "Notification 2", description: "Description 2", imageName: "bell.fill"),
    // Add more notification items here
]
