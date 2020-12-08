//
//  UserFollow.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 8/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class UserFollower {
    var uid: String
    var isFollowed: Bool
    var uid_follower: String
    
    init(uid: String, isFollowed: Bool, uid_follower: String) {
        self.uid = uid
        self.isFollowed = isFollowed
        self.uid_follower = uid_follower
    }
}
