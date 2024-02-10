//
//  AuthenticationViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation

// View model for handling authentication-related operations
@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // Asynchronously signs in an anonymous user
    func signInAnonymous() async throws {
        // Attempt to sign in anonymously using AuthenticationManager
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        
        // Create a new user in UserManager based on the authentication result
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
    
    // Asynchronously signs in a user using email and password
    func signInEmail(email: String, password: String) async throws {
        // Attempt to sign in with email and password using AuthenticationManager
        let authDataResult = try await AuthenticationManager.shared.signInEmail(email: email, password: password)
        
        // Create a new user in UserManager based on the authentication result
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}

