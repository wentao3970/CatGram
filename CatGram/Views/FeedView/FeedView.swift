//
//  FeedView.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var posts: PostArrayObject
    var title: String
        
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
            
            LazyVStack {
                ForEach(posts.dataArray) { post in
                    PostView(post: post, showHeaderAndFooter: true, addheartAnimationToView: true)
                }
            }
        })
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{countPost(posts: posts)}
    }
    
    
    // MARK: FUNCTIONS
    
    func countPost(posts: PostArrayObject) {
        print("There are \(posts.dataArray.count) posts showing in current feedview")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject(shuffled: false), title: "Feed Test")
        }
    }
}
