//
//  PostModel.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID()
    
    // postID : id for the post in Database
    var postID: String
    
    // userID
    var userID: String
    
    // user username
    var username: String
    
    // caption - optional
    var caption: String?
    
    // date
    var dateCreated: Date
    
    // like count
    var likeCount: Int
    
    // linked by current user
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
