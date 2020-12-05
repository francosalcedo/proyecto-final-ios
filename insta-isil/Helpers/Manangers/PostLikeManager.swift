//
//  PostLikeManager.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation
import Firebase

class PostLikeManager {
    
    
    
    static func setPostLikeToDocument(postLike: PostLike) {
        let data_postLike = [
            "\(postLike.userId)" : postLike.isLiked
        ]
        getRef().document(postLike.postId).updateData(data_postLike) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    private static func createPostLikeToDocument(postLike: PostLike) {
        let data_postLike = [
            "\(postLike.userId)" : postLike.isLiked
        ]
        getRef().document(postLike.postId).setData(data_postLike) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    static func isLikedByCurrentUser(postId: String, completation: @escaping (Bool) -> Void )  {
        getRef().document(postId).getDocument() { document, err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                let data = document?.data()
                guard let isLiked: Bool = data?[getCurrentUserUId()] as? Bool else {
                    let post_like = PostLike(postId: postId, userId: getCurrentUserUId(), isLiked: true)
                    createPostLikeToDocument(postLike: post_like)
                    return
                }
                completation(isLiked)
            }
        }
    }
    
    static func getPostLikes(postId: String, completion: @escaping ([PostLike]) -> Void) {
        getDocumentByPostId(postId: postId) { data in
            var postLikes: [PostLike] = []
            for (uid, isLiked) in data{
                let post_like = PostLike(postId: postId, userId: uid, isLiked: isLiked as! Bool)
                postLikes.append(post_like)
            }
            completion(postLikes)
        }
    }
    
    private static func getDocumentByPostId(postId: String, completion: @escaping ([String: Any]) -> Void){
        let ref = getRef().document(postId)
        
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
        let postRef = db.collection("postLikes")
        return postRef
    }
}
