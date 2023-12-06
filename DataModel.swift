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
    @Published var followedConcerts: [ListItem] = []

    func followConcert(concert: Event) {
        let date = String(concert.datetimeUTC.prefix(10)) // Extract date
        let time = String(concert.datetimeUTC.dropFirst(11)) // Extract time
        let listItem = ListItem(name: concert.venue.name, imageName: "defaultConcertImage", date: date, time: time)
        
        if !followedConcerts.contains(where: { $0.name == concert.venue.name && $0.date == date && $0.time == time }) {
            followedConcerts.append(listItem)
        }
    }

    func toggleConcertFollowState(concert: Event) {
        let date = String(concert.datetimeUTC.prefix(10))
        let time = String(concert.datetimeUTC.dropFirst(11))
        let listItem = ListItem(name: concert.venue.name, imageName: "defaultConcertImage", date: date, time: time)
        
        if let index = followedConcerts.firstIndex(where: { $0.name == concert.venue.name && $0.date == date && $0.time == time }) {
            followedConcerts.remove(at: index)
        } else {
            followedConcerts.append(listItem)
        }
    }

    func isConcertFollowed(concert: Event) -> Bool {
        let date = String(concert.datetimeUTC.prefix(10))
        let time = String(concert.datetimeUTC.dropFirst(11))
        return followedConcerts.contains(where: { $0.name == concert.venue.name && $0.date == date && $0.time == time })
    }

    @Published var followedArtists: [ListItem] = []

    func followArtist(artist: Artist) {
        let listItem = ListItem(name: artist.name, imageName: artist.image ?? "defaultImageName", date: "", time: "")
            if !followedArtists.contains(where: { $0.name == artist.name }) {
                followedArtists.append(listItem)
            }
    }
    func toggleArtistFollowState(artist: Artist) {
        let listItem = ListItem(name: artist.name, imageName: artist.image ?? "defaultImageName", date: "", time: "")
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
    let date: String // New field for date
    let time: String

    init(id: UUID = UUID(), name: String, imageName: String, date: String, time: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.date = date
        self.time = time
    }
}
