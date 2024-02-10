//
//  DataTypes.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import SwiftUI
// Data structure representing a specific type of data
struct DataTypes: Identifiable, Decodable {
    // Unique identifier for each instance
    var id: String
    // Unique identifier for each instance
    var userId: String
    // Title property describing the data
    var title: String
    
    // Description property providing additional details about the data
    var description: String
    
    // Uncomment the following lines if additional properties exist in your data structure
    var imageUrl: String
//    var status: String
}

