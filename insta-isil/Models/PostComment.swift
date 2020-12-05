//
//  Comments.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation

class PostComment {
    var id:String
    var postId: String
    var caption: String
    var uid: String
    
    init(id: String, postId: String, caption: String, uid: String) {
        self.id = id
        self.postId = postId
        self.caption = caption
        self.uid = uid
    }
    
}
