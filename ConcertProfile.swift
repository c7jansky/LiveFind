//
//  ConcertProfile.swift
//  LiveFind
//
//  Created by keckuser on 12/3/23.
//

import SwiftUI

struct ConcertProfile: View {
    let event: Event

       var body: some View {
           VStack {
               Text("Event Details")
                   .font(.title)

               // Display details of the event using properties from the 'event' object
               Text("Event ID: \(event.id)")
               Text("Date: \(event.datetimeUTC)")
               Text("Venue: \(event.venue.name)")
               Text("State: \(event.venue.state)")
               Text("City: \(event.venue.city)")
               ForEach(event.performers, id: \.id) { performer in
                   Text("Performer: \(performer.name)")
               }
               // Add more details as needed

               Spacer()
           }
           .padding()
       }
   }

struct ConcertProfile_Previews: PreviewProvider {
    static var previews: some View {
        let samplePerformer = Performer(type: "Artist", name: "John Doe", image: "john_doe_image", id: 456)
        let sampleEvent = Event(type: "Concert", id: 123, datetimeUTC: "2023-12-01T19:00:00", venue: Venue(state: "CA", name: "Sample Venue", postalCode: "12345", city: "Los Angeles"), performers:[samplePerformer])
        
        ConcertProfile(event: sampleEvent)
    }
}
