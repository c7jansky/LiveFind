//
//  SearchView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI


struct SearchView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    private var listOfCountry = countryList
    @State var searchText = ""
    
    
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
