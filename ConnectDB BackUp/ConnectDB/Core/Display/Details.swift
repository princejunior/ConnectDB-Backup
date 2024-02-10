//
//  Details.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI
import SDWebImageSwiftUI

// View for displaying details of a user
struct Details: View {
    // User data to be displayed
    let userItem: DataTypes
    
    var body: some View {
        // Use GeometryReader to access the size of the containing view
        GeometryReader { geo in
            VStack {
                // Display the username using the title property of DataTypes
                Text("Username: \(userItem.title)")
                    .font(.title)
                
                // Uncomment the following lines if 'image' is a property of DataTypes
                //                AnimatedImage(url: URL(string: userItem.imageUrl))
                //                    .resizable().frame(height: geo.size.height - 100)
                //                    .padding(.horizontal, 15)
                //                    .cornerRadius(20)
                //
                WebImage(url: URL(string: userItem.imageUrl))
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 20)
                
                VStack(alignment: .leading) {
                    // Displaying user title
                    Text(userItem.title)
                        .font(.headline)
                    
                    // Displaying user description
                    Text(userItem.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
            }
        }
    }
}

// Preview provider for Details
//#Preview {
//    Details(userItem: DataTypes)
//}
