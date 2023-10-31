//
//  ArtistProfile.swift
//  LiveFind
//
//  Created by keckuser on 10/17/23.
//

import SwiftUI

struct ArtistProfile: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    var body: some View {
        ScrollView{
            VStack{
                
                Image("Dre")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
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
        .ignoresSafeArea()
        .background(Primary)
        .overlay(backButton, alignment: .topLeading)
        
    }
}

struct ArtistProfile_Previews: PreviewProvider {
    static var previews: some View {
        ArtistProfile()
    }
}

extension ArtistProfile{
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Dr. Dre")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Secondary)
            Text("Rap, R&B")
                .font(.subheadline)
                .foregroundColor(Secondary)
        }
    }
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Andre Romell Young, known professionally as Dr. Dre, is an American rapper and record producer. He is the founder and CEO of Aftermath Entertainment and Beats Electronics, and previously co-founded, co-owned, and was the president of Death Row Records.")
                .font(.subheadline)
                .foregroundColor(Secondary)
                
            
            if let url = URL(string:"https://seatgeek.com/dr-dre-tickets") {
                Link("Buy Tickets on SeatGeek", destination: url)
                    .font(.headline)
                    .padding()
            }
        }
    }
    
    private var concertSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("No Upcoming Concerts")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Secondary)
        }
        /*List{
            HStack{
                Text("country.capitalized")
                    .foregroundColor(Secondary)
                Spacer()
                Image(systemName: "figure.walk")
                    .foregroundColor(Secondary)
                }
                .padding()
        }
        .listRowBackground(Primary)*/
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
