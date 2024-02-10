//
//  AuthenticationManager.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import Foundation
import FirebaseAuth

// Model representing the result of authentication
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    // Initialize the model using a Firebase User object
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

// Enum representing different authentication provider options
enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

// Manager class for handling authentication operations
final class AuthenticationManager {
    
    // Singleton instance for shared access
    static let shared = AuthenticationManager()
    private init() {}
    
    // Get the currently authenticated user or throw an error
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    // Create a new user with email and password
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign in a user with email and password
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Send a password reset email to the provided email address
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // Update the user's password
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    // Update the user's email and send a verification email
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    // Sign out the current user
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Delete the current user's account
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
}

// Extension for additional authentication methods
extension AuthenticationManager {
    // Sign in anonymously and return the AuthDataResultModel
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign in with email and password and return the AuthDataResultModel
    @discardableResult
    func signInEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
