//
//  NotificationsView.swift
//  LiveFind
//
//  Created by keckuser on 9/26/23.
//

import SwiftUI

struct NotificationsView: View {
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    var body: some View {
        ZStack{            
            Image(systemName: "bell.fill")
                .foregroundColor(Color.blue)
                .font(.system(size: 100.0))
        }
        .ignoresSafeArea()
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
