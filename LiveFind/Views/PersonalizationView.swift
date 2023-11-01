//
//  PersonalizationView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct PersonalizationView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    var artistData = userSavedData.savedData()
    
    var body: some View {
        
        
        NavigationView{
            
//            List(artistData, children: \.subArtists){ data in
//                HStack{
//                    Image(data.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width : 50, height : 50)
//
//                    Text(data.name)
//                        .font(.subheadline)//.system(.title3, design: .rounded))
//                        .bold()
//                        .foregroundColor(Secondary)
//
//                }
//                .listRowBackground(Primary)
//
//            }
//            .listStyle(.inset)
//            .navigationTitle("My Follows")
//            .font(.title2)
//            .background(Primary)
//            .navigationBarTitleDisplayMode(.large)
            ScrollView{

                VStack(alignment: .leading ,spacing: 16.0){

                    artistFollows

                    List(artistData, children: \.subArtists){ data in
                        HStack{
                            Image(data.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width : 50, height : 50)
                            Text(data.name)
                                .font(.subheadline)//.system(.title3, design: .rounded))
                                .bold()
                        }
                    }
                    .listStyle(.inset)

                    Divider()
                        .frame(minHeight: 3)
                        .background(Secondary)
                        .ignoresSafeArea()

                    concertFollows
                    
                    List(artistData, children: \.subArtists){ data in
                        HStack{
                            Image(data.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width : 50, height : 50)
                            Text(data.name)
                                .font(.subheadline)//.system(.title3, design: .rounded))
                                .bold()
                        }
                    }
                    .listStyle(.inset)

                    Divider()
                        .frame(minHeight: 3)
                        .background(Secondary)
                        .ignoresSafeArea()

                    calendarTitle


                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            }
            .listStyle(.inset)
            .navigationTitle("My Follows")
            .font(.title2)
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

struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}


extension PersonalizationView{
    
    private var artistFollows: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Followed Artists")
                .font(.title)
                .foregroundColor(Secondary)
        }
    }
    
    private var concertFollows: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Followed Concerts")
                .font(.title)
                .foregroundColor(Secondary)

        }
    }
    private var calendarTitle: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Calendar")
                .font(.title)
                .foregroundColor(Secondary)
        }
    }
}
