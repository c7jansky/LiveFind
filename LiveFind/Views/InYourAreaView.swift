//
//  inYourAreaView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct inYourAreaView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    var body: some View {
        NavigationView{
            
            ScrollView{
                
            }
            .navigationTitle("In My Area")
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

struct inYourAreaView_Previews: PreviewProvider {
    static var previews: some View {
        inYourAreaView()
    }
}
