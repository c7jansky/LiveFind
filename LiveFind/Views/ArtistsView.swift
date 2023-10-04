//
//  Artists.swift
//  LiveFind
//
//  Created by Berke Voskeriçyan on 1.10.2023.
//

import Foundation
import SwiftUI

struct Artist: Hashable, Codable {
    let name: String
    let image: String
    let id: Int
    let has_upcoming_event: String
    let links: String
}

struct Artists: Hashable, Codable {
    var performers: [Artist]
}
class ArtistModel: ObservableObject {
    @Published var artists: [Artists] = []
    func FetchArtists() {
        guard let url = URL(string:"https://api.seatgeek.com/2/performers?client_id=MzcxNTkzODF8MTY5NjIwMTQ0Ni4wMTMxMzE") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in guard let data = data, error == nil else{
            return
        }
            do {
                let artists = try JSONDecoder().decode([Artists].self, from:data)
                DispatchQueue.main.async{
                    self?.artists = artists
                }
            }
            catch{
                print(error)
                
            }
        }
        task.resume()
}


}
struct ArtistsView: View {
    @StateObject var artistModel = ArtistModel()
    
    var body: some View {
        NavigationView {
            List {
                //ForEach(artistModel.artists, id: \.self) { artist in
                ForEach(0 ..< artistModel.artists.count, id: \.self) { artist in
                    HStack {
                        Image("")
                            .frame(width:130, height:70)
                            .background(Color.blue)
                        Text(self.artistModel.artists[artist].performers[artist].name)
                            .bold()
                    }
                    
                }
            }
            .navigationTitle("Artists")
            .onAppear {
                artistModel.FetchArtists()
            }
            
        }
    }
}

//#Preview {
//    ArtistsView()
//}
struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}

