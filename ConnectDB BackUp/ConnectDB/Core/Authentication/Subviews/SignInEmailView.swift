//
//  SignInEmailView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

// View for signing in with email
struct SignInEmailView: View {
    // View model for handling sign-in with email operations
    @StateObject private var viewModel = SignInEmailViewModel()
    
    // View model for handling general authentication operations
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    // Binding to control the visibility of the sign-in view
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            // Text field for entering the email
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            // Secure field for entering the password
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            // Button to trigger sign-in or sign-up
            Button {
                Task {
                    do {
                        // Try signing up with provided email and password
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    do {
                        // If sign-up fails, attempt sign-in
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign in")
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
        .navigationTitle("Sign in With Email")
    }
}

// Preview provider for SignInEmailView
#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
