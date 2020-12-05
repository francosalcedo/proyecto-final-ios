//
//  PostCommentManager.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation
import Firebase

class PostCommentManager {
    
    static func setPostCommentToDocument(postComment: PostComment) {
        let data_postComment = [
            "uid" : "\(postComment.uid)",
            "postId" : "\(postComment.postId)",
            "caption" : postComment.caption
        ]
        print("Aqui estamos")
        getRef().document(postComment.id).updateData(data_postComment) { error in
            if let _ = error {
                let documentID = getRef().document().documentID
                getRef().document(postComment.id).setData(data_postComment) { sub_error in
                    if let sub_error = sub_error {
                        print(sub_error.localizedDescription)
                    }
                }
            }
        }
    }
    
    static func getPostCommentsByPostId(postId: String,response: @escaping ([PostComment]) -> Void) {
        var postComments: [PostComment] = []
        getDocumentsByPostId(postId: postId) { documents in
            for document in documents {
                let id = document.documentID
                let uid = document["uid"] ?? ""
                let caption = document["caption"] ?? ""
                let postId = document["postId"] ?? ""
                
                let postComment = PostComment(id: "\(id)",postId: "\(postId)", caption: "\(caption)", uid: "\(uid)")
                postComments.append(postComment)
            }
            response(postComments)
        }
    }
    
    private static func getDocumentsByPostId(postId: String, completion: @escaping ([QueryDocumentSnapshot]) -> Void){
        let ref = getRef().whereField("postId", isEqualTo: postId)
        
        ref.getDocuments() { snapshot, err in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                guard let documents = snapshot?.documents else {
                    return
                }
                completion(documents)
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
        let postRef = db.collection("postComments")
        return postRef
    }
}
