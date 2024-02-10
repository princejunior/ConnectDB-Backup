////
////  DisplayView.swift
////  ConnectDB
////
////  Created by Elijah Elliott on 1/27/24.
////
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

// View for displaying a list of users with navigation links to their details
struct DisplayView: View {
    // Observable object for observing changes in the data
    @ObservedObject var obser = observer()
    
    // Binding to control the visibility of the sign-in view
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            List(obser.users) { user in
                // Navigation link to the details view for each user
                NavigationLink(destination: Details(userItem: user)) {
                    HStack {
                        // Uncomment the following code if 'image' is a property of DataTypes
                        WebImage(url: URL(string: user.imageUrl))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        
                        VStack(alignment: .leading) {
                            // Displaying user title
                            Text(user.title)
                                .font(.headline)
                            
                            // Displaying user description
                            Text(user.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)
                    }
                }
            }
            .navigationTitle("Display")
        }
    }
}
