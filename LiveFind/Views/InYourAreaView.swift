//
//  inYourAreaView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct inYourAreaView: View {
    var body: some View {
        ZStack{
            Color("PrimaryColor")
            
            Image(systemName: "map")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
        .ignoresSafeArea()
    }
}

struct inYourAreaView_Previews: PreviewProvider {
    static var previews: some View {
        inYourAreaView()
    }
}
