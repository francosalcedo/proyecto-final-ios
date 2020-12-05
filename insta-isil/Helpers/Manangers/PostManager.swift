
import Foundation
import Firebase

class PostManager {
    
    static func getPostsByCurrentUser(response: @escaping ([Post]) -> Void) {
        var posts: [Post] = []
        getDocumentsByUser(uid: getCurrentUserUId()) { documents in
            for document in documents {
                let id = document.documentID
                let uid = document["uid"] ?? ""
                let caption = document["caption"] ?? ""
                let post = Post(id: id,uid: "\(String(describing: uid))", caption: "\(String(describing: caption))")
                posts.append(post)
            }
            response(posts)
        }
    }
    
    private static func getDocumentsByUser(uid: String, completion: @escaping ([QueryDocumentSnapshot]) -> Void){
        let ref = getPostsRef().whereField("uid", isEqualTo: uid)
        
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
    
    private static func getPostsRef() -> CollectionReference {
        let db = Firestore.firestore()
        let postRef = db.collection("posts")
        return postRef
    }
}
