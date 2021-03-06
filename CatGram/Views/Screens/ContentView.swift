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
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)
    
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: feedPosts, title: "Feed View")
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Feed")
            }

            NavigationView {
                BrowserView(posts: browsePosts)
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
                if let userID = currentUserID, let displayName = currentDisplayName {
                    NavigationView {
                        ProfileView(isMyProfile: true, profileDisplayName: displayName, profileUserID: userID, posts: PostArrayObject(userID: userID))
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
