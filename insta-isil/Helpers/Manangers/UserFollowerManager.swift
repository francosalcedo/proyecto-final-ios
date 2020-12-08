//
//  UserFollowerManager.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 8/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

class UserFollowerManager {
    static func setUserFollowerToDocument(_ userFollower: UserFollower) {
        let data = [
            "\(userFollower.uid_follower)" :userFollower.isFollowed
        ]
        getRef().document(userFollower.uid).updateData(data) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    private static func createUserFollowerToDocument(userFollower: UserFollower) {
        let data_userFollower = [
            "\(userFollower.uid_follower)" : userFollower.isFollowed
        ]
        getRef().document(userFollower.uid).setData(data_userFollower) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    static func isFollowingByCurrentUser(uid: String, completation: @escaping (Bool) -> Void )  {
        getRef().document(uid).getDocument() { document, err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                let data = document?.data()
                guard let isFollowed: Bool = data?[getCurrentUserUId()] as? Bool else {
                    let userFollower = UserFollower(uid: uid, isFollowed: true, uid_follower: getCurrentUserUId())
                    if let document = document, document.exists {
                        setUserFollowerToDocument(userFollower)
                    } else {
                        createUserFollowerToDocument(userFollower: userFollower)
                    }
                    return
                }
                completation(isFollowed)
            }
        }
    }
    
    static func getUserFollowers(uid: String, completion: @escaping ([UserFollower]) -> Void) {
        getDocumentByUserUId(uid: uid) { data in
            var userFollowers: [UserFollower] = []
            for (uid_follower, isFollowing) in data {
                let userFollower = UserFollower(uid: uid, isFollowed: isFollowing as! Bool, uid_follower: uid_follower)
                userFollowers.append(userFollower)
            }
            completion(userFollowers)
        }
    }
    
    private static func getDocumentByUserUId(uid: String, completion: @escaping ([String: Any]) -> Void){
        let ref = getRef().document(uid)
        
        ref.getDocument { document, err in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                guard let data: [String: Any] = document?.data() else {
                    return
                }
                completion(data)
            }
        }
    }
    
    private static func getCurrentUserUId() -> String{
        let user = Auth.auth().currentUser
        
        guard let user_uid = user?.uid else {
            return ""
        }
        return user_uid
    }
    
    private static func getRef() -> CollectionReference {
        let db = Firestore.firestore()
        let postRef = db.collection("userFollowers")
        return postRef
    }
}
