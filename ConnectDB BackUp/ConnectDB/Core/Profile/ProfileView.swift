//
//  ProfileView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI



struct ProfileView: View {
    
    @StateObject private var profileViewModel = ProfileViewModel()
    
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        List {
                    if let user = profileViewModel.user {
                        Text("UserId: \(user.uid)")
                        ForEach(profileViewModel.users) { userInfo in
                            Text("UserId: \(userInfo.userId)")
                            Text("UserName: \(userInfo.userName)")
                            Text("About: \(userInfo.aboutUser)")
                            Text("Image URL: \(userInfo.imageUrl)")
                        }
                    }
                }
//        List {
//            if let user = viewModel.user {
//                Text("UserId: \(user.uid)")
//            }
//        }
        .onAppear {
            try? profileViewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    UploadProfileView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
