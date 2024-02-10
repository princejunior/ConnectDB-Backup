//
//  observer.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import SwiftUI
import Firebase

//class observer : ObservableObject {
////    @Published var users =
//    @Published var users = [DataTypes]()
//    
//    static let shared = UserManager()
//
//    init() {
//        let db = Firestore.firestore()
//        db.collection("users").getDocuments { (snap,err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//            }
//            
//            for i in snap!.documents {
//                let name = i.get("name") as! String
//                let age = i.get("age") as! String
//                let image = i.get("image") as! String
//                let id = i.documentID
//                let status = i.get("status") as! String
//                
//                if status == "" {
//                    self.users.append(DataTypes(id:id, name:name, image:image, age:age, status: status))
//                }
//            }
//        }
//    }
//    
//}


// new code
import Foundation
import Firebase

// Observable object for managing and observing user data
class observer: ObservableObject {
    // Published property to store an array of user data
    @Published var users = [DataTypes]()
    
    // Initializer that triggers data fetching upon object creation
    init() {
        fetchData()
    }
    
    // Function to fetch user data from Firestore
    func fetchData() {
        // Access Firestore
        let db = Firestore.firestore()
        
        // Add a snapshot listener to the "content" collection
        db.collection("content").addSnapshotListener { (snap, err) in
            // Check for errors and unwrap the snapshot's documents
            guard let documents = snap?.documents else {
                print("Error fetching documents: \(err?.localizedDescription ?? "Unknown error")")
                return
            }

            // Map Firestore documents to an array of DataTypes
            self.users = documents.compactMap { document in
                do {
                    // Decode Firestore document into DataTypes
                    let data = try document.data(as: DataTypes.self)
                    print(data)
                    return data
                } catch {
                    // Handle decoding errors
//                    print("Error decoding document with ID \(document.documentID): \(error)")
//                    print("Document data: \(document.data() ?? [:])")
                    return nil
                }
            }
        }
    }
}
