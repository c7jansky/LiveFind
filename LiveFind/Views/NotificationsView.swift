//
//  NotificationsView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct NotificationsView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                
            }
            .navigationTitle("Notifications")
            .font(.title2)
            .ignoresSafeArea()
            .background(Primary)
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Primary)
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.init(Secondary)]
            
            appearance.titleTextAttributes = [
                            .foregroundColor: UIColor.init(Secondary),
                            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}


extension NotificationsView{
    
    private var TitleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Notifications")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Secondary)
        }
    }
}

