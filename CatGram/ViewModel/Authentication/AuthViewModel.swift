//
//  AuthViewModel.swift
//  CatGram
//
//  Created by Wentao Wu on 7/12/21.
//

import Foundation
import SwiftUI


class AuthViewModel: ObservableObject {
    @Environment(\.presentationMode) var presentationMode
    
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var providerID: String = ""
    @Published var provider: String = ""
    @Published var imageSelected: UIImage = UIImage(named: "logo")!
    
    
    @State var isSuccessfullyLogedIn = false
    
    func signInWithEmail() {
        
    }
    
    func signInWithGoogle() {
        
    }
    
    func signInWithApple() {
        
    }
    
    
    

    
}
