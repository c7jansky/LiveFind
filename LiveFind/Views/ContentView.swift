//
//  ContentView.swift
//  LiveFind
//
//  Created by keckuser on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            inYourAreaView()
                .tabItem(){
                    Image(systemName: "map.fill")
                    Text("Nearby")
                }
            NotificationsView()
                .badge(69)
                .tabItem(){
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            PersonalizationView()
                .tabItem(){
                    Image(systemName: "person.circle")
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
	
