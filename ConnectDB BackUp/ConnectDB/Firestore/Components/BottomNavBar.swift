//
//  BottomNavBar.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/29/24.
//

import SwiftUI

import SwiftUI

struct BottomNavBar: View {
    @Binding var showSignInView: Bool

    var body: some View {
        HStack {
            // Navigation link for the ProfileView
            NavigationLink(destination: ProfileView(showSignInView: $showSignInView)) {
                Image(systemName: "person")
                    .font(.headline)
            }
            .padding(.horizontal)

            Spacer()

            // Navigation link for the UploadView
            NavigationLink(destination: UploadView(showSignInView: .constant(false))) {
                Image(systemName: "plus")
                    .font(.headline)
            }
            .padding(.horizontal)
        }
//        .padding(.vertical, 5)
//        .background(Color.white) // Optional background color
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}


#Preview {
    BottomNavBar(showSignInView: .constant(false))
}
