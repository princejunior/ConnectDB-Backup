//
//  content.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//
import Foundation
import SwiftUI
import Firebase

// Observable object for managing user content
class content: ObservableObject {
    // Published property to store an array of ContentType
    @Published var users = [DataTypes]()
    
    // Singleton instance for shared access
    static let shared = UserManager()
    
    // Initializer to fetch user content from Firestore
    init() {
        // Access Firestore
        let db = Firestore.firestore()
        
        // Query the "users" collection
        db.collection("users").getDocuments { (snap, err) in
            // Check for errors
            if let error = err {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            // Iterate through the documents in the snapshot
            for document in snap!.documents {
                // Extract user data from Firestore document
                let id = document.documentID
                let title = document.get("name") as! String
                let image = document.get("image") as? String ?? ""
                let description = document.get("description") as! String
//                let status = document.get("status") as! String
                let user_id = ""
                
                // Create a ContentType object and add it to the users array
                self.users.append(DataTypes(id: id,userId: user_id, title: title, description: description, imageUrl: image))
            }
        }
    }
}
