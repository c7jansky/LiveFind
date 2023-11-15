//
//  DataModel.swift
//  LiveFind
//
//  Created by keckuser on 11/15/23.
//

import Foundation

struct DataModel {
    static let firstListItems = [ListItem(name: "Artist 1", imageName: "artist1Image"),
                                 ListItem(name: "Artist 2", imageName: "artist2Image"),
                                 // ... more items
                                ]

    static let secondListItems = [ListItem(name: "Concert 1", imageName: "concert1Image"),
                                  ListItem(name: "Concert 2", imageName: "concert2Image"),
                                  // ... more items
                                 ]
}

struct ListItem {
    let name: String
    let imageName: String
}
