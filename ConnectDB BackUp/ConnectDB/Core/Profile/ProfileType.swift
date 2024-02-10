//
//  ProfileType.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 2/10/24.
//

import Foundation

struct ProfileTypes: Identifiable, Decodable {
    // Unique identifier for each instance
    var id: String
    // Unique identifier for each instance
    var userId: String
    // Title property describing the data
    var userName: String
    
    // Description property providing additional details about the data
    var aboutUser: String
    
    // Uncomment the following lines if additional properties exist in your data structure
    var imageUrl: String
//    var status: String
}
