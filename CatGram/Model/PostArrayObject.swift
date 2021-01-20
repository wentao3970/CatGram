//
//  PostArrayObject.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    @Published var postCountString = "0"
    @Published var likeCountString = "0"
//    init() {
//
//        print("Fetch from data base here")
//
//        let post1 = PostModel(postID: "", userID: "", username: "Wentao Wu", caption: "this is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
//
//        let post2 = PostModel(postID: "", userID: "", username: "Xiaoyu Zhu", caption: "1111111", dateCreated: Date(), likeCount: 0, likedByUser: false)
//
//        let post3 = PostModel(postID: "", userID: "", username: "Joe Green", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
//
//        let post4 = PostModel(postID: "", userID: "", username: "Chris Pan", caption: "wow", dateCreated: Date(), likeCount: 0, likedByUser: false)
//
//        let post5 = PostModel(postID: "", userID: "", username: "Xiaowei", dateCreated: Date(), likeCount: 1, likedByUser: false)
//
//        self.dataArray.append(post1)
//        self.dataArray.append(post2)
//        self.dataArray.append(post3)
//        self.dataArray.append(post4)
//        self.dataArray.append(post5)
//    }
    
    
    /// USED FOR SINGLE POST SELECTION
    init (post: PostModel) {
        self.dataArray.append(post)
    }
    
    /// USED FOR GETTING POSTS FOR USER PROFILE
    init(userID: String) {
        
        print("GET POSTS FOR USER ID \(userID)")
        DataService.instance.downloadPostForUser(userID: userID) { (returnedPosts) in
            
            let sortedPosts = returnedPosts.sorted{ (post1, post2) -> Bool in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
            self.updateCounts()
        }
    }
    
    /// USED FOR FEED
    init(shuffled: Bool) {
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        DataService.instance.downloadPostsForFeed { (returnedPosts) in
            if shuffled {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
    
    func updateCounts() {
        
        // post count
        self.postCountString = "\(self.dataArray.count)"
        
        // like count
        let likeCountArray = dataArray.map { (existingPosts) -> Int in
            return existingPosts.likeCount
        }
        let sumOfLikeCountArray = likeCountArray.reduce(0, +)
        self.likeCountString = "\(sumOfLikeCountArray)"
    }
    
}
