//
//  ContentView.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: PostArrayObject(), title: "FEED VIEW")
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Feed")
            }
            
            NavigationView {
                BrowserView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack {
                if currentUserID != nil {
                    NavigationView {
                        ProfileView(isMyProfile: true, profileDisplayName: "MY PROFILE", profileUserID: "")
                    }
                } else {
                    SignUpView()
                }
                
            }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
