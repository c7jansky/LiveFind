//
//  userSavedData.swift
//  LiveFind
//
//  Created by keckuser on 10/31/23.
//

import Foundation
import SwiftUI

struct userSavedData: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var subArtists: [userSavedData]?
    
}


//Data

extension userSavedData{
    
    static func savedData() -> [userSavedData]{
        
        let artists: [userSavedData] = [
            userSavedData(name: "Dr. Dre", image : "Dre")
        ]
        
        let items : [userSavedData] = [userSavedData(name: "Followed Artists", image: "heart", subArtists: artists)]
        
        return items
    }
    
    
}
