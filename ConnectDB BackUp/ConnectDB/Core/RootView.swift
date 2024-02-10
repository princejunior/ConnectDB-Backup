//
//  RootView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

// Root view of the application
struct RootView: View {
    // State variable to control the visibility of the sign-in view
    @State private var showSignInView: Bool = false
    
    var body: some View {
        // ZStack to manage the navigation stack and conditionally display views
        ZStack {
            // Check if the sign-in view should not be shown
            if !showSignInView {
                // Display the navigation stack with the main content views
                NavigationStack {
                    // Uncomment and add other views as needed
                    MainView(showSignInView: $showSignInView)
//                    DisplayView(showSignInView: $showSignInView)
//                    ProfileView(showSignInView: $showSignInView)
//                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        // Execute code when the view appears
        .onAppear() {
            // Attempt to get the authenticated user
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            
            // Set the showSignInView state based on whether the user is authenticated
            self.showSignInView = authUser == nil
        }
        // Full screen cover to display the sign-in view if needed
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                // Display the AuthenticationView within the navigation stack
                AuthenticationView(showSignInView: $showSignInView)
            }
        })
    }
}

// Preview provider for RootView
#Preview {
    RootView()
}
