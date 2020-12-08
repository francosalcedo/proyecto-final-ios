//
//  UserManager.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 6/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManager {
    
    static func setDataToUserByUid(_ user: User!) {
        let data: [String: Any] = [
            "uid": "\(user.uid!)",
            "firstname": "\(user.firstname!)",
            "lastname": "\(user.lastname!)",
            "carrera": "\(user.carrera!)",
            "sede": "\(user.sede!)",
            "birthday": "\(user.birthday!)",
            "image-url": "\(user.imageUrl!)"
        ]
        
        let document = getRef().document("\(user.uid!)")
        
        document.updateData(data) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    static func getDataFromUserByUId(uid: String,completion: @escaping (User?) -> Void ) {
        getDocumentByUId(uid: uid) { document in
            let uid = "\(String(describing: document?["uid"] ?? ""))"
            let firstname = "\(String(describing: document?["firstname"] ?? ""))"
            let lastname = "\(String(describing: document?["lastname"] ?? ""))"
            let carrera = "\(String(describing: document?["carrera"] ?? ""))"
            let sede = "\(String(describing: document?["sede"] ?? ""))"
            let birthday = "\(String(describing: document?["birthday"] ?? ""))"
            let imageUrl = "\(String(describing: document?["image-url"] ?? ""))"
            
            let newUser = User(uid: uid, firstname: firstname, lastname: lastname, carrera: carrera, sede: sede, birthday: birthday, imageUrl: imageUrl)
            completion(newUser)
        }
    }
    
    static func getDataFromCurrentUser(completation: @escaping (User?) -> Void ) {
        let user = getCurrentUser()
        getDocumentByUId(uid: user?.uid) { document in
            let uid = "\(String(describing: document?["uid"] ?? ""))"
            let firstname = "\(String(describing: document?["firstname"] ?? ""))"
            let lastname = "\(String(describing: document?["lastname"] ?? ""))"
            let carrera = "\(String(describing: document?["carrera"] ?? ""))"
            let sede = "\(String(describing: document?["sede"] ?? ""))"
            let birthday = "\(String(describing: document?["birthday"] ?? ""))"
            let imageUrl = "\(String(describing: document?["image-url"] ?? ""))"
            
            let newUser = User(uid: uid, firstname: firstname, lastname: lastname, carrera: carrera, sede: sede, birthday: birthday, imageUrl: imageUrl)
            completation(newUser)
        }
    }
    
    //MARK: - Private Functions
    
    private static func getDocumentByUId(uid: String!, completion: @escaping ([String: Any]?) -> Void){
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
    
    static func getCurrentUser() -> FirebaseAuth.User? {
        let user = FirebaseAuth.Auth.auth().currentUser
        return user
    }
    
    private static func getRef() ->  CollectionReference {
        let db = Firestore.firestore()
        let ref = db.collection("users")
        return ref
    }
}
