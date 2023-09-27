//
//  SearchView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack{
            Color.gray
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
