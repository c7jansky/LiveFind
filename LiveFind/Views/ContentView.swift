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
                .environmentObject(DataModel.shared)
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Secondary)
                    Text("Search")
                }
                //.toolbarBackground(Primary, for: .tabBar)
            
            inYourAreaView()
                .tabItem(){
                    Image(systemName: "map.fill")
                        .foregroundColor(Secondary)
                    Text("Nearby")
                }
                //.toolbarBackground(Primary, for: .tabBar)
            NotificationsView()
                .badge(2)
                .tabItem(){
                    Image(systemName: "bell.fill")
                        .foregroundColor(Secondary)
                    Text("Notifications")
                }
                //.toolbarBackground(Primary, for: .tabBar)
            PersonalizationView()
                .environmentObject(DataModel.shared)
                .tabItem(){
                    Image(systemName: "person.circle")
                        .foregroundColor(Primary)
                    Text("Profile")
                }
                //.toolbarBackground(Primary, for: .tabBar)
        }
        .accentColor(Secondary)
        .environment(\.colorScheme, .dark)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

