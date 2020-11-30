//
//  ProfileViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 29/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var carreraTxtLbl: UILabel!
    @IBOutlet weak var sedeTxtLabel: UILabel!
    @IBOutlet weak var fech_nacTxtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultValues()
        
        let user = Auth.auth().currentUser
        let user_email = user?.email
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user_email ?? "")
        
        userRef.getDocument { snapshot, error in
            if let data = snapshot?.data() {
                let name =  "\(data["firstname"] ?? "Anynomous") \(data["lastname"] ?? "Anynomous")"
                let carrera = "\(data["carrera"] ?? "-")"
                let sede = "\(data["sede"] ?? "-")"
                let birthday = "\(data["birthday"] ?? "-")"
                self.nameTxtLbl.text = name
                self.carreraTxtLbl.text = carrera
                self.sedeTxtLabel.text = sede
                self.fech_nacTxtLabel.text = birthday
            }
        }
    }
    
    private func setDefaultValues() {
        self.photoImage.image = UIImage(named: "user-photo")
        self.photoImage.layer.cornerRadius = 90
        
        self.nameTxtLbl.text = "-"
        self.carreraTxtLbl.text = "-"
        self.sedeTxtLabel.text = "-"
        self.fech_nacTxtLabel.text = "-"
    }
}
