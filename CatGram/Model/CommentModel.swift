//
//  CommentModel.swift
//  CatGram
//
//  Created by Wentao on 1/14/21.
//

import Foundation
import SwiftUI

struct CommentModel : Identifiable, Hashable{
    
    var id = UUID()
    
    // ID for the comment in the Database
    var commentID: String
    
    // ID for the user in the Database
    var userID: String
    
    var username: String
    
    var content: String
    
    var dateCreated: Date
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
