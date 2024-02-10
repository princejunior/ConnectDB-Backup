//
//  UserManager.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Manager class for handling user-related operations
final class UserManager : ObservableObject{
//    private var userId = ""
    
    // Singleton instance for shared access
    static let shared = UserManager()
    // Initialize the user manager and fetch initial user data from Firestore
    init() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snap, err) in
            // Handle the fetched user documents if needed
            // Currently, it does not perform any specific actions
        }
    }
    
    // Create a new user in Firestore based on the provided AuthDataResultModel
    func createNewUser(auth: AuthDataResultModel) async throws {
        // Prepare user data to be stored in Firestore
        var userData: [String: Any] = [
            "user_id": auth.uid,
            "data_created": Timestamp(),
        ]
        
        // Add optional user information if available
        if let email = auth.email {
            userData["email"] = email
        }
        
        // Attempt to set user data in Firestore
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
        
    }
    
//    func getUserID() {
//        return self.userId
//    }
//    
//    func setUserId(user_id: String) {
//        self.userId = user_id
//    }
    
}
