//
//  Post.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 30/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation

class Post {
    var id: String?
    var uid: String?
    var caption: String?
    
    init(id: String, uid: String, caption: String) {
        self.id = id
        self.uid = uid
        self.caption = caption
    }
}
