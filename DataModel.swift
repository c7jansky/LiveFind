//
//  DataModel.swift
//  LiveFind
//
//  Created by keckuser on 11/15/23.
//

import Foundation
import Combine

class DataModel: ObservableObject {
    static var shared = DataModel()

    var firstListItems: [ListItem] {
        didSet {
            saveListItems()
        }
    }

    var secondListItems: [ListItem] {
        didSet {
            saveListItems()
        }
    }

    init() {
        self.firstListItems = DataModel.loadListItems(key: "FirstListItems") ?? []
        self.secondListItems = DataModel.loadListItems(key: "SecondListItems") ?? []
    }
    
    @Published var followedArtists: [ListItem] = []

    func followArtist(artist: Artist) {
            let listItem = ListItem(name: artist.name, imageName: artist.image ?? "defaultImageName")
            if !followedArtists.contains(where: { $0.name == artist.name }) {
                followedArtists.append(listItem)
            }
    }
    func toggleArtistFollowState(artist: Artist) {
            let listItem = ListItem(name: artist.name, imageName: artist.image ?? "defaultImageName")
            if let index = followedArtists.firstIndex(where: { $0.name == artist.name }) {
                followedArtists.remove(at: index)
            } else {
                followedArtists.append(listItem)
            }
        }

    func isArtistFollowed(artist: Artist) -> Bool {
            followedArtists.contains(where: { $0.name == artist.name })
        }

    private func saveListItems() {
        DataModel.saveListItems(self.firstListItems, key: "FirstListItems")
        DataModel.saveListItems(self.secondListItems, key: "SecondListItems")
    }

    private static func saveListItems(_ items: [ListItem], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    private static func loadListItems(key: String) -> [ListItem]? {
        let decoder = JSONDecoder()
        if let savedItems = UserDefaults.standard.object(forKey: key) as? Data,
           let loadedItems = try? decoder.decode([ListItem].self, from: savedItems) {
            return loadedItems
        }
        return nil
    }
}

struct ListItem: Codable, Identifiable {
    var id: UUID
    let name: String
    let imageName: String

    init(id: UUID = UUID(), name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
}
