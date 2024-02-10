//
//  SettingsView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI



// View for displaying user settings and options
struct SettingsView: View {
    // View model for handling settings-related operations
    @StateObject private var viewModel = SettingsViewModel()
    
    // Binding to control the visibility of the sign-in view
    @Binding var showSignInView: Bool
    
    var body: some View {
        // List of settings options
        List {
            // Button to log out the user
            Button("Log Out") {
                Task {
                    do {
                        // Attempt to sign out the user
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            // Button to delete the user's account
            Button(role: .destructive) {
                Task {
                    do {
                        // Attempt to delete the user's account
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            
            // Email-related section
            emailSection
        }
        .navigationTitle("Settings")
    }
}

// Preview provider for SettingsView
#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}

// Extension containing the email-related functions
extension SettingsView {
    private var emailSection: some View {
        Section {
            // Button to reset the user's password
            Button("Reset Password") {
                Task {
                    do {
                        // Attempt to reset the user's password
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            // Button to update the user's password
            Button("Update Password") {
                Task {
                    do {
                        // Attempt to update the user's password
                        try await viewModel.updatePassword()
                        print("Password Updated")
                    } catch {
                        print(error)
                    }
                }
            }
            
            // Button to update the user's email
            Button("Update Email") {
                Task {
                    do {
                        // Attempt to update the user's email
                        try await viewModel.updateEmail()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            // Section header for email-related functions
            Text("Email Functions")
        }
    }
}
