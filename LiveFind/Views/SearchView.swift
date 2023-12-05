//
//  SearchView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//
// Commit Token: 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

import SwiftUI

struct Artist: Hashable, Codable {
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    let name: String
    let id: Int
    let url: String
    let image: String?
    let links: Array<String>
    let genres: [Genre]?
    let has_upcoming_events: Bool
}
struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    let primary: Bool
}



struct Artists: Hashable, Codable {
    public var performers: [Artist]
}
class ArtistModel: ObservableObject {
    @Published var artists: [Artist] = []
    func FetchArtists(searchQuery: String? = nil) {
        var urlString = "https://api.seatgeek.com/2/performers?"

                if let searchQuery = searchQuery, !searchQuery.isEmpty {
                    urlString += "slug=" + searchQuery
                } else {
                    urlString += "per_page=5000&taxonomies.name=concerts"
                }

                urlString += "&client_id=MzcxNTkzODF8MTY5NjIwMTQ0Ni4wMTMxMzE"

                guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: encodedUrlString) else {
                    return
                }

                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]
        
    }

    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top){
                List{
                    ForEach(artistModel.artists.filter {
                        // Filter artists based on the search text
                        searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                    }, id: \.id) { artist in
                        NavigationLink(destination: ArtistProfile(artist: artist), label: {
                            HStack {
                                if let imageURL = URL(string: artist.image ?? "") {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .success(let image):
                                                image
                                                .resizable()
                                                .scaledToFill() // Fill the frame while maintaining aspect ratio
                                                .frame(width: 70, height: 70) // Set the frame size (circular diameter)
                                                .clipShape(Circle()) // Clip the image to a circle
                                                .overlay(Circle().stroke(Secondary, lineWidth: 2))
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
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Secondary, lineWidth: 2))
                                }
                                //Text(self.artistModel.artists[artist].name)
                                Text(artist.name)
                                    .bold()
                                    .foregroundColor(Secondary)
                                
                                
                            }
                            .padding()
                        }
                     )
                    }
                    
                    
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Artists")
                .onAppear {
                    artistModel.FetchArtists()
                    
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { newSearchText in
                                    artistModel.FetchArtists(searchQuery: newSearchText)
                                }
            }
            
        }
        .environment(\.colorScheme, .dark)
        //.overlay(filterButton, alignment: .topTrailing).ignoresSafeArea()
    }
    
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
