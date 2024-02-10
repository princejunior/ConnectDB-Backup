//
//  AuthenticationView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

// Function to sign in anonymously using the AuthenticationManager
func signInAnonymous() async throws {
    try await AuthenticationManager.shared.signInAnonymous()
}

// View for authentication, includes a button to sign in anonymously and a NavigationLink for email sign-in
struct AuthenticationView: View {
    // View model for managing authentication state
    @StateObject private var viewModel = AuthenticationViewModel()
    
    // Binding for controlling the visibility of the sign-in view
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            // Button to trigger anonymous sign-in
            Button(action: {
                Task {
                    do {
                        // Attempt to sign in anonymously
                        try await viewModel.signInAnonymous()
                        
                        // If successful, hide the sign-in view
                        showSignInView = false
                    } catch {
                        // Handle any errors during sign-in
                        print(error)
                    }
                }
            }, label: {
                Text("Sign in Anonymously")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
            // Navigation link to the email sign-in view
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            // Spacer for layout
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

// Preview for the AuthenticationView
#Preview {
    AuthenticationView(showSignInView: .constant(false))
}
