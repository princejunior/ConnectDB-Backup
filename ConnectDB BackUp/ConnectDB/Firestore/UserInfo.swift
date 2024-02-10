//
//  UserInfo.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 2/9/24.
//

import Foundation

import Firebase

import Foundation

@MainActor
final class UserInfo : ObservableObject {
    
    @Published private(set) var user : AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
}
