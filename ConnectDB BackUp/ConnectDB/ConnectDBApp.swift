//
//  ConnectDBApp.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI
import Firebase

@main
struct ConnectDBApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init () {
//        FirebaseApp.configure()
//        print("Configured Firebase!")
//    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase!")
        return true
    }
}
