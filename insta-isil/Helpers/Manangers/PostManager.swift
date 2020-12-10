
import Foundation
import Firebase

class PostManager {
    
    static func getPostsAll(response: @escaping ([Post]) -> Void) {
        var posts: [Post] = []
        getDocumentsAll { documents in

        }
    }
    
    static func getPostsByCurrentUser(response: @escaping ([Post]) -> Void) {
        var posts: [Post] = []
        getDocumentsByUser(uid: getCurrentUserUId()) { documents in

        }
    }
    
    static func deletePostByPostId(_ postId: String) {
        getPostsRef().document(postId).delete() { err in

        }
    }
    
    //MARK: - Private Functions
    
    private static func getDocumentsAll(completion: @escaping ([QueryDocumentSnapshot]) -> Void){
        let ref = getPostsRef()
        
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

    }
}
