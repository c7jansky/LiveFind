//
//  SearchView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//
// Commit Token: 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

import SwiftUI


struct SearchView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    private var listOfCountry = countryList
    @State var searchText = ""
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]
        UINavigationBar.appearance().backgroundColor = UIColor.init(Primary)
        
    }
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(countries, id: \.self) {country in
                    HStack{
                        Text(country.capitalized)
                            .foregroundColor(Secondary)
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundColor(Secondary)
                    }
                    .padding()
                }
                .listRowBackground(Primary)
            }
            
            .searchable(text: $searchText)
            .navigationTitle("Artists")
            
        }
               
    }
    
    
    var countries: [String]{
        let lcCountries = listOfCountry.map {$0.lowercased() }
        
        return searchText == "" ? lcCountries : lcCountries.filter {
            $0.contains(searchText.lowercased())
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//   ZStack{
  //     Color("PrimaryColor")
       
    //   Image(systemName: "magnifyingglass")
      //     .foregroundColor(Color.blue)
        //   .font(.system(size: 100.0))
   //}
