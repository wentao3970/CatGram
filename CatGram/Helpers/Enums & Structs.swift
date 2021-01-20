//
//  Enums & Structs.swift
//  CatGram
//
//  Created by Wentao on 1/18/21.
//

import Foundation

struct DatabaseUserField { // Fields within the User Document in Database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    
}

struct DatabasePostField { // Fields within Post Document in Database
    
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "date_created"
    static let likeCount = "like_count" // Int
    static let likedBy = "liked_by" // array
    static let comments = "comments" // sub-collection
}

struct DatabaseCommentsField { // Fields within the Comment SUBcollection of a Post Document
    
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"
    
}

struct DatabaseReportField { // Field within Report Document in Database
    
    static let content = "content"
    static let postID = "post_id"
    static let dateCreated = "date_created"
    
}

struct CurrentUserDefaults { // Fields for UserDefaults saved within app
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
    
}
