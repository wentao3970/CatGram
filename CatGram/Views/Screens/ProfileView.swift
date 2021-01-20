//
//  ProfileView.swift
//  CatGram
//
//  Created by Wentao on 1/15/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var isMyProfile: Bool
    
    @State var profileDisplayName: String
    var profileUserID: String
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var posts: PostArrayObject
    
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage)
            
            Divider()
            
            ImageGridView(posts: posts)
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                                .opacity(isMyProfile ? 1.0 : 0.0)
        )
        .onAppear(perform: {
            getProfileImage()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
                .preferredColorScheme(colorScheme)
        })
    }
    
    // MARK: FUNCTIONS
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(isMyProfile: true, profileDisplayName: "Joe", profileUserID: "", posts: PostArrayObject(userID: ""))
        }
        .preferredColorScheme(.light)
    }
}
