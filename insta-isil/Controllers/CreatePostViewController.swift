//
//  CreatePostViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 3/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import Firebase

class CreatePostViewController: UIViewController {
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var publishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
    }
    func configureComponents() {
        captionTextView.layer.borderColor = UIColor(red: CGFloat(0x00) / 255.0,
                                                    green: CGFloat(0xAE) / 255.0,
                                                    blue: CGFloat(0xEF) / 255.0,
                                                    alpha: 1).cgColor
        captionTextView.layer.borderWidth = 2
    }
    @IBAction func didTapPublicar(_ sender: Any) {
        var msg: String = ""
        var errorValidate = false
        
        let caption = captionTextView.text
        
        if caption == "" { msg = msg + "\n Descripcion Invalido o Vacio" }
        
        if !(msg == "") {
            errorValidate = true
        } else {
            msg = "Se encontraron Errores:" + msg
        }
        
        if !errorValidate {
            let user = Auth.auth().currentUser
            let user_uid = user?.uid
            let db = Firestore.firestore()
            let postRef = db.collection("posts").document()
            
            let data = ["uid": user_uid, "caption": caption]
            
            postRef.setData(data as [String : Any]) { error in
                if error != nil {
                    
                    return
                }
            }
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        } else {
            print("ERROR AL SUBIR DATOS")
        }
    }
}
