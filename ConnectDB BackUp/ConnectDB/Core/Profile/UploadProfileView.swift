//
//  UploadProfileView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 2/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct UploadProfileView: View {
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
//            if let user = profileViewModel.user {
//                Text("UserId: \(user.uid)")
//                if let userInfo = profileViewModel.users {
//                    Text("UserId: \(userInfo.imageUrl)")
//                   
//                }
//            }
//        }
        .onAppear {
           try? profileViewModel.loadCurrentUser()
        }
        .navigationTitle("Profile Upload")
    }
}

#Preview {
    UploadProfileView(showSignInView: .constant(false))
}


//                VStack(alignment: .leading) {
//                    // Displaying user title
//                    // Uncomment the following code if 'image' is a property of DataTypes
//                    WebImage(url: URL(string: user.))
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .clipShape(Circle())
//                    .shadow(radius: 20)
//                    Text(user.title)
//                        .font(.headline)
//
//                    // Displaying user description
//                    Text(user.description)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                .padding(.leading, 10)
