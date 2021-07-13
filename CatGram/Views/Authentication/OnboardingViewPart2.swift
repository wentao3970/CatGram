//
//  OnboardingViewPart2.swift
//  CatGram
//
//  Created by Wentao on 1/15/21.
//

import SwiftUI

struct OnboardingViewPart2: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel()
    
    @State private var showError: Bool = false
    
    // For image picker
    //    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var showImagePicker: Bool = false
    
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    
    var body: some View {
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
            
            Text("What's your name?")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.MyTheme.yellowColor)
            
            TextField("Add your name here...", text: $authViewModel.displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .foregroundColor(.black)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding()
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellowColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            })
            .accentColor(Color.MyTheme.purpleColor)
            .opacity(authViewModel.displayName != "" ? 1.0 : 0.0)
            .animation(.easeIn(duration: 1.0))
        })
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.MyTheme.purpleColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .sheet(isPresented: $showImagePicker,
               onDismiss: createProfile,
               content: {
                ImagePicker(imageSelected: $authViewModel.imageSelected, sourceType: $sourceType)
               })
        .alert(isPresented: $showError) { () -> Alert in
            return Alert(title: Text("Error creating profile 🧐"))
        }
    }
    
    
    func createProfile() {
        
        print("CREATE PROFILE NOW")
        AuthService.instance.createNewUserInDatabase(name: authViewModel.displayName, email: authViewModel.email, providerID: authViewModel.providerID, provider: authViewModel.provider, profileImage: authViewModel.imageSelected) { (returnedUserID) in
            
            if let userID = returnedUserID {
                // SUCESS
                print("Successfully created new user in database")
                
                AuthService.instance.logInUserToApp(userID: userID) { (success) in
                    if success {
                        print("User logged in!")
                        // return to app
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    } else {
                        print("Error logging in")
                        self.showError.toggle()
                        
                    }
                }
                
            } else {
                // ERROR
                print("Error creating user in Database")
                self.showError.toggle()
            }
            
        }
    }
    
    
}


