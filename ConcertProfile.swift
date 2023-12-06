//
//  ConcertProfile.swift
//  LiveFind
//
//  Created by keckuser on 12/3/23.
//

import SwiftUI

struct ConcertProfile: View {
    let Secondary = Color("SecondaryColor")
    let event: Event
    
    @EnvironmentObject var dataModel: DataModel
    
    private var followButton: some View {
            Button(action: {
                dataModel.toggleConcertFollowState(concert: event)
            }) {
                HStack {
                    Text(dataModel.isConcertFollowed(concert: event) ? "Unfollow Event" : "Follow Event")
                        .font(.headline)
                        .foregroundColor(Secondary)
                    Image(systemName: dataModel.isConcertFollowed(concert: event) ? "heart.fill" : "heart")
                        .foregroundColor(Secondary)
                }
                .padding(10)
                .background(Color("PrimaryColor"))
                .cornerRadius(10)
                .shadow(radius: 4)
            }
        }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                Spacer()
                    .frame(height: 20)
                    
                Text(event.venue.name)
                    .font(.title)
                    .foregroundColor(Secondary)

                Text("Date: \(String(event.datetimeUTC.prefix(10)))")
                    .foregroundColor(Secondary)

                Text("Time: \(String(event.datetimeUTC.dropFirst(11)))")
                    .foregroundColor(Secondary)

                Text("State: \(event.venue.state)")
                    .foregroundColor(Secondary)

                Text("City: \(event.venue.city)")
                    .foregroundColor(Secondary)
                    
                
                Divider()
                    .frame(minHeight: 1)
                    .background(Secondary)
                

                Text("Performers:")
                    .font(.title)
                    .foregroundColor(Secondary)

                ForEach(event.performers, id: \.id) { performer in
                    Text(performer.name)
                        .foregroundColor(Secondary)
                }
                
                Spacer()
            
            }
            .padding([.leading, .trailing, .bottom])
            .navigationBarTitle("Event Details")//, displayMode: .inline)
            .overlay(followButton, alignment: .topTrailing)

        }
        .ignoresSafeArea()
    }
}



struct ConcertProfile_Previews: PreviewProvider {
    static var previews: some View {
        let samplePerformer = Performer(type: "Artist", name: "John Doe", image: "john_doe_image", id: 456)
        let sampleEvent = Event(type: "Concert", id: 123, datetimeUTC: "2023-12-01T19:00:00", venue: Venue(state: "CA", name: "Venue Name", postalCode: "12345", city: "Los Angeles", location: Location(lat: 0.34, lon: 0.34)), performers: [samplePerformer])
        
        ConcertProfile(event: sampleEvent)
    }
}

