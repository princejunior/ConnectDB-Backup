//
//  ProfileViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import Firebase

@MainActor
final class ProfileViewModel : ObservableObject {
    //added
    @Published var users = [ProfileTypes]()
    private var isUploadSuccessful = false
    
    //original
    @Published private(set) var user : AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
        findUserProfile()
    }
    
    func findUserProfile() {
        // Access Firestore
        let db = Firestore.firestore()
        
        // Add a snapshot listener to the "content" collection
        db.collection("content").whereField("userId", isEqualTo: user?.uid).addSnapshotListener { (snap, err) in
            // Check for errors and unwrap the snapshot's documents
            guard let documents = snap?.documents else {
                print("Error fetching documents: \(err?.localizedDescription ?? "Unknown error")")
                return
            }

            // Map Firestore documents to an array of DataTypes
            self.users = documents.compactMap { document in
                do {
                    // Decode Firestore document into DataTypes
                    let data = try document.data(as: ProfileTypes.self)
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
    
    func uploadUserProfile(profileImageUrl: URL, userName: String, aboutUser: String) {
        let db = Firestore.firestore()

        let contentCollection = db.collection("content")

       
        if let userId = try? AuthenticationManager.shared.getAuthenticatedUser().uid {
                var documentData: [String: Any] = [
                    "userName": userName,
                    "aboutUser": aboutUser,
                    "imageUrl": profileImageUrl,
                    "userId": userId
                ]
            
            print(documentData)
            let contentDocument = contentCollection.document()
            
            documentData["id"] = contentDocument.documentID
            
            contentDocument.setData(documentData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully with ID: \(contentDocument.documentID)")
                    self.isUploadSuccessful = true
                }
            }
        }
    }
}
