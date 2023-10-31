//
//  SearchView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//
// Commit Token: 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

import SwiftUI

struct Artist: Hashable, Codable {
    let name: String
    let id: Int
    let links: Array<String>
}

struct Artists: Hashable, Codable {
    public var performers: [Artist]
}
class ArtistModel: ObservableObject {
    @Published var artists: [Artist] = []
    
    func FetchArtists() {
        guard let url = URL(string:"https://api.seatgeek.com/2/performers?per_page=5000&taxonomies.name=concerts&client_id=MzcxNTkzODF8MTY5NjIwMTQ0Ni4wMTMxMzE") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in guard let data = data, error == nil else{
            return
        }
            do {
                let artists = try JSONDecoder().decode(Artists.self, from:data)
                DispatchQueue.main.async{
                    self?.artists = artists.performers
                }
            }
            catch{
                print(error)
                
            }
        }
        task.resume()
    }
    
}
    
struct SearchView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    let gradient = LinearGradient(colors: [Color.orange,Color.green],
                                      startPoint: .top, endPoint: .bottom)
    private var listOfCountry = countryList
    private var listOfArtists = ArtistModel().artists
    @State private var listOfNames: [String] = []
    @StateObject var artistModel = ArtistModel()
    @State var searchText = ""
    @State var search: String = ""
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .top){
                
                List{
                    
                    ForEach(Array(0 ..< artistModel.artists.count), id: \.self) { artist in
                        //NavigationLink(destination: ArtistProfile(artist:self.artistModel.artists.[artist])){
                            
                            HStack {
                                Image("")
                                    .frame(width:110, height:70)
                                    .background(Color.blue)
                                Text(self.artistModel.artists[artist].name)
                                    .bold()
                                    .foregroundColor(Secondary)
                                
                                
                            }
                            .padding()
                            
                            //listOfNames.append(self.artistModel.artists[artist].performers[artist].name)
                        //}
                    }
                    .listRowBackground(Primary)
                    
                    //.onChange(of: search, perform: performSearch)
                    
                    /*ForEach(countries, id: \.self) {country in
                     HStack{
                     Text(country.capitalized)
                     .foregroundColor(Secondary)
                     Spacer()
                     Image(systemName: "figure.walk")
                     .foregroundColor(Secondary)
                     }
                     .padding()
                     }
                     .listRowBackground(Primary)*/
                    
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Artists")
                .searchable(text: $searchText)
                .onAppear {
                    artistModel.FetchArtists()
                    
                }
            }
            
        }
        .overlay(filterButton, alignment: .topTrailing).ignoresSafeArea()
        .background(Primary)
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
    

    
    
        //var Names: [String]{
         
             //ForEach(0 ..< artistModel.artists.count, id: \.self) { artist in
             //artistList.add(self.artistModel.artists[artist].performers[artist].name)         }
         //let artistLits = listOfArtists.map
         //let listOfArtists = artistModel.artists.filter { artist in
             //artistModel.artists[artist].performers[artist].name
         //let lcArtists = listOfArtists.artists.performers[Artist].name.flatMap { name in return name.lowercased() }
         //ForEach(0 ..< artistModel.artists.count, id: \.self) { artist in
         //   listOfNames.append(artistModel.artists[artist].performers[artist].name)
             
         //}
    var Names: [String]{
        
         artistModel.artists.forEach{ artist in
    //         for perfomer in artist.performers {
             listOfNames.append(artist.name.lowercased())
             
             }
       //
             let ArrayofNames = Array(listOfNames)
             
             let lcNames = ArrayofNames.map {$0.lowercased() }
             
             return searchText == "" ? lcNames.map{$0.lowercased()} : lcNames.filter {
                 $0.contains(searchText.lowercased())
                 
         }
     }
     
     
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension SearchView{
    
    private var filterButton: some View {
        Button{
            
        } label: {
            Text("Filters")
                .font(.headline)
                .padding(16)
                .foregroundColor(Secondary)
                .background(Primary)
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding(30)
        }
        
    }
}

//   ZStack{
  //     Color("PrimaryColor")
       
    //   Image(systemName: "magnifyingglass")
      //     .foregroundColor(Color.blue)
        //   .font(.system(size: 100.0))
   //}
