//
//  ContentView.swift
//  LiveFind
//
//  Created by keckuser on 9/19/23.
//
// Commit Token: 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

import SwiftUI

struct ContentView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    var body: some View {
        
        TabView(){
            
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Secondary)
                    Text("Search")
                }
            inYourAreaView()
                .tabItem(){
                    Image(systemName: "map.fill")
                        .foregroundColor(Secondary)
                    Text("Nearby")
                }
            NotificationsView()
                .badge(69)
                .tabItem(){
                    Image(systemName: "bell.fill")
                        .foregroundColor(Secondary)
                    Text("Notifications")
                }
            PersonalizationView()
                .tabItem(){
                    Image(systemName: "person.circle")
                        .foregroundColor(Primary)
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
	
