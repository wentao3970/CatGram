//
//  PostArrayObject.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init() {
        
        print("Fetch from data base here")
        
        let post1 = PostModel(postID: "", userID: "", username: "Wentao Wu", caption: "this is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post2 = PostModel(postID: "", userID: "", username: "Xiaoyu Zhu", caption: "1111111", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post3 = PostModel(postID: "", userID: "", username: "Joe Green", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post4 = PostModel(postID: "", userID: "", username: "Chris Pan", caption: "wow", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post5 = PostModel(postID: "", userID: "", username: "Xiaowei", dateCreated: Date(), likeCount: 1, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
        self.dataArray.append(post5)
    }
    
    
    /// USED FOR SINGLE POST SELECTION
    init (post: PostModel) {
        self.dataArray.append(post)
    }
    
    
}
