//
//  CatGramApp.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
@main
struct DogGramApp: App {
    
    init() {
        FirebaseApp.configure()
        
        // For google sign in
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance().handle(url) // For Google sign in
                })
        }
    }
}
