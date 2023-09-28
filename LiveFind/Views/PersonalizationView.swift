//
//  PersonalizationView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct PersonalizationView: View {
    var body: some View {
        ZStack{
            Color("PrimaryColor")
            
            Image(systemName: "person.fill")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
    }
}

struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}
