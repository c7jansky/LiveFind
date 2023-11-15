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
    var body: some View {
        ZStack{
            Color("PrimaryColor")
            
            Image(systemName: "person.fill")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
        .ignoresSafeArea()
    }
}

struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}


extension PersonalizationView{
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Dr. Dre")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Secondary)
            Text("Rap, R&B")
                .font(.subheadline)
                .foregroundColor(Secondary)
        }
    }
}
