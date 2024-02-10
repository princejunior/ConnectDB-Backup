//
//  SettingsViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation

// View model for handling user settings and options
@MainActor
final class SettingsViewModel: ObservableObject {
    
    // Signs out the current user
    func signOut() throws {
        // Attempt to sign out using AuthenticationManager
        try AuthenticationManager.shared.signOut()
    }
    
    // Deletes the current user's account
    func deleteAccount() async throws {
        // Attempt to delete the user's account using AuthenticationManager
        try await AuthenticationManager.shared.delete()
    }
    
    // Resets the password for the authenticated user
    func resetPassword() async throws {
        // Get the authenticated user
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        // Ensure the user has an email
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        // Attempt to reset the password using AuthenticationManager
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    // Updates the email for the authenticated user
    func updateEmail() async throws {
        // New email address
        let email = "hello@gmail.com"
        
        // Attempt to update the email using AuthenticationManager
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    // Updates the password for the authenticated user
    func updatePassword() async throws {
        // New password
        let password = "1234567"
        
        // Attempt to update the password using AuthenticationManager
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}
