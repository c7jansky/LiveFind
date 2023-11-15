//
//  inYourAreaView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct Venue: Codable {
    let state: String
    let name: String
    let postalCode: String
    let city: String
    // Add other properties as needed
}

struct Performer: Codable {
    let type: String
    let name: String
    let image: String
    let id: Int
    // Add other properties as needed
}

struct Event: Codable {
    let type: String
    let id: Int
    let datetimeUTC: String
    let venue: Venue
    let performers: [Performer]
    // Add other properties as needed
}

// Fetch and parse JSON data
class EventViewModel: ObservableObject {
    @Published var events: [Event] = []

    init() {
        fetchData()
    }

    func fetchData() {
        // Replace "your_json_url" with the actual URL of your JSON data
        if let url = URL(string: "https://api.seatgeek.com/2/events?taxonomies.name=concert&datetime_utc.gte=2023-11-13&datetime_utc.lte=2023-12-13&venue.city=Los Angeles&client_id=MzcxNTkzODF8MTY5NjIwMTQ0Ni4wMTMxMzE/") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode([Event].self, from: data)
                        DispatchQueue.main.async {
                            self.events = decodedData
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
}





struct inYourAreaView: View {
    var body: some View {
        ZStack{
            Color("PrimaryColor")
            
            Image(systemName: "map")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
        .ignoresSafeArea()
    }
}

struct inYourAreaView_Previews: PreviewProvider {
    static var previews: some View {
        inYourAreaView()
    }
}
