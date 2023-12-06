//
//  ArtistProfile.swift
//  LiveFind
//
//  Created by keckuser on 10/17/23.
//

import SwiftUI

struct ArtistProfile: View {
    
    @State private var events: [Event] = []
    let artist: Artist
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    @EnvironmentObject var dataModel: DataModel
    
    init(artist: Artist) {
        self.artist = artist
    }
    var body: some View {
        ScrollView{
            VStack{
                if let imageURL = URL(string: artist.image ?? "") {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                        case .empty:
                            ProgressView()
                        case .failure(_):
                            Text("Image Not Available")
                        @unknown default:
                            EmptyView() // Or any other appropriate view for unexpected cases
                        }
                    }
                    
                } else {
                    Image(systemName: "guitars.fill")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                }
            }
            
            VStack(alignment: .leading, spacing: 16){
                titleSection
                Divider()
                    .frame(minHeight: 3)
                    .background(Secondary)
                descriptionSection
                Divider()
                    .frame(minHeight: 3)
                    .background(Secondary)
                concertSection
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .environment(\.colorScheme, .dark)
        .overlay(followButton, alignment: .topTrailing)

        .onAppear{
            fetchData(forArtist: String(artist.id))
        }
        
    }
    
}


struct ArtistProfile_Previews: PreviewProvider {
    static var previews: some View {

        ArtistProfile(artist: Artist(name: "Dr. Dre", id: 11369,url: "äbc",image: "SKSDK",  links: ["link1"], genres: [Genre(
            id: 1,
            name: "Pop",
            slug: "pop_slug",
            primary: true), Genre(
                id: 1,
                name: "Pop",
                slug: "pop_slug",
                primary: true)], has_upcoming_events: false ))
    }
}

extension ArtistProfile{

    private func fetchData(forArtist artistId: String) {
        let apiUrl = "https://api.seatgeek.com/2/events?performers.id=" + String(artist.id) + "&client_id=MzcxNTkzODF8MTY5NjIwMTQ0Ni4wMTMxMzE"
            if let url = URL(string: apiUrl) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(EventResponse.self, from: data)
                            DispatchQueue.main.async {
                                self.events = decodedData.events
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                }.resume()
            }
        }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(artist.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Secondary)
            Text((artist.genres?.map { $0.name } ?? []) .joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(Secondary)
                
        }
    }
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
//            Text("DESCRIPTION PLACEHOLDER PLS CHANGE" ) //+ String(artist.id))
//                .font(.subheadline)
//                .foregroundColor(Secondary)
                
            
            if let url = URL(string:artist.url) {
                Link("Buy Tickets on SeatGeek", destination: url)
                    .font(.headline)
                    .padding()
            }
        }
    }
    
    private var concertSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if artist.has_upcoming_events == false {
                Text("No Upcoming Concerts")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Secondary)
            } else {
                ForEach(events) { event in
                    VStack {
                        NavigationLink(destination: ConcertProfile(event: event)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Venue: \(event.venue.name)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Secondary)

                                    // Display only the first 10 characters of the date
                                    Text("Date: \(String(event.datetimeUTC.prefix(10)))")
                                        .font(.subheadline)
                                        .foregroundColor(Secondary)

                                    // Display everything after the 11th character as time
                                    Text("Time: \(String(event.datetimeUTC.dropFirst(11)))")
                                        .font(.subheadline)
                                        .foregroundColor(Secondary)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Secondary)
                            }
                        }
                        Divider()
                            .frame(minHeight: 1)
                            .background(Secondary)
                    }
                }
            }
            Spacer()
        }
    }


    
    private var backButton: some View {
        Button{
            
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(Secondary)
                .background(Primary)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
        
        
    }
    private var followButton: some View {
            Button(action: {
                dataModel.toggleArtistFollowState(artist: artist)
            }) {
                HStack {
                    Text(dataModel.isArtistFollowed(artist: artist) ? "Unfollow Artist" : "Follow Artist")
                        .font(.headline)
                        .foregroundColor(Secondary)

                    Image(systemName: dataModel.isArtistFollowed(artist: artist) ? "heart.fill" : "heart")
                        .foregroundColor(Secondary)
                }
                .padding(10)
                .background(Primary) // Replace with your primary color
                .cornerRadius(10)
                .shadow(radius: 4)
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
        }
    
}
