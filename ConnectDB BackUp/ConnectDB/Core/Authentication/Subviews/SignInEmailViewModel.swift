//
//  SignInEmailViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
// View model for handling sign-in and sign-up with email operations
@MainActor
final class SignInEmailViewModel: ObservableObject {
    // Published properties for email and password
    @Published var email = ""
    @Published var password = ""
    
    // Asynchronously attempts to sign in the user
    func signIn() async throws {
        // Check if email and password are not empty
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        // Attempt to sign in the user using AuthenticationManager
        let returnUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    // Asynchronously attempts to sign up the user
    func signUp() async throws {
        // Check if email and password are not empty
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        // Attempt to create a new user using AuthenticationManager
        let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}
