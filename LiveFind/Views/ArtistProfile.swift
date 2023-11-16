//
//  ArtistProfile.swift
//  LiveFind
//
//  Created by keckuser on 10/17/23.
//

import SwiftUI

struct ArtistProfile: View {
    let artist: Artist
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    
    
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
        //.ignoresSafeArea()
        //.background(Primary)
        //.overlay(backButton, alignment: .topLeading)
        .overlay(followButton, alignment: .topTrailing)
        
        
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
                primary: true)], has_upcoming_events: true ))
    }
}

extension ArtistProfile{
    
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
            Text("Andre Romell Young, known professionally as Dr. Dre, is an American rapper and record producer. He is the founder and CEO of Aftermath Entertainment and Beats Electronics, and previously co-founded, co-owned, and was the president of Death Row Records.")
                .font(.subheadline)
                .foregroundColor(Secondary)
                
            
            if let url = URL(string:artist.url) {
                Link("Buy Tickets on SeatGeek", destination: url)
                    .font(.headline)
                    .padding()
            }
        }
    }
    
    private var concertSection: some View{
        VStack(alignment: .leading, spacing: 8){
            if(artist.has_upcoming_events == false){
                Text("No Upcoming Concerts")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Secondary)
            } else {
                Text(artist.name + " will soon be performing")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Secondary)
            }
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
        Button{
            
        } label: {
            Image(systemName: "heart")
                .font(.headline)
                .padding(16)
                .foregroundColor(Secondary)
                .background(Primary)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
        
        
    }
    
}

/*
struct ArtistProfileData: Hashable, Codable {
    let name: String
    let id: Int
    let links: Array<String>
}
*/

// name + Dr. Dre
// id = 13635
// links = []
// has upcomingevents = false
