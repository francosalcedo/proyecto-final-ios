//
//  PostLike.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation

class PostLike {
    var postId: String
    var userId: String
    var isLiked: Bool
    
    init(postId: String, userId: String, isLiked: Bool) {
        self.postId = postId
        self.userId = userId
        self.isLiked = isLiked
    }

}
