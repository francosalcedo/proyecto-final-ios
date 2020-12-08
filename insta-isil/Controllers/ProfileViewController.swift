//
//  ProfileViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 29/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var carreraTxtLbl: UILabel!
    @IBOutlet weak var sedeTxtLabel: UILabel!
    @IBOutlet weak var fech_nacTxtLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var userFrom: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultValues()
        UserManager.getDataFromUserByUId(uid: UserManager.getCurrentUser()!.uid) { user in
            if self.userFrom == nil {
                self.userFrom = user!
            }
            self.setValues()
            self.setupUI()
            self.uiUserIsntFollowButton()
        }
    }
    
    //MARK: - Values
    
    private func setValues() {
        UserManager.getDataFromUserByUId(uid: userFrom.uid){ user in
            let name = "\(user?.firstname ?? "") \(user?.lastname ?? "")"
            let carrera = user?.carrera ?? ""
            let sede = user?.sede ?? ""
            let birthday = user?.birthday ?? ""
            
            if let imageUrlString: String = user?.imageUrl {
                let url:URL? = URL(string: imageUrlString)
                if url != nil {
                    do {
                        let data = try Data(contentsOf: url!)
                        self.photoImage.image = UIImage(data: data)
                        self.photoImage.sizeToFit()
                    } catch {
                        print("No encontre Imagen en la url papuh")
                        self.photoImage.image = UIImage(named: "user-photo")
                    }
                } else {
                    print("No es un string")
                    self.photoImage.image = UIImage(named: "user-photo")
                }
                
            } else {
                print("No se consiguio imagen papuh")
                self.photoImage.image = UIImage(named: "user-photo")
            }
            // Set Values
            self.nameTxtLbl.text = name
            self.carreraTxtLbl.text = carrera
            self.sedeTxtLabel.text = sede
            self.fech_nacTxtLabel.text = birthday
        }
    }

    private func setDefaultValues() {
        self.nameTxtLbl.text = ""
        self.carreraTxtLbl.text = ""
        self.sedeTxtLabel.text = ""
        self.fech_nacTxtLabel.text = ""
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        let colorPink: CGColor! = CGColor(red: CGFloat(0xFD) / 255.0, green: CGFloat(0x7D) / 255.0, blue: CGFloat(0xFF) / 255.0, alpha: 1)
        
        photoImage.image = UIImage(named: "user-photo")
        photoImage.layer.cornerRadius = 75
        photoImage.contentMode = .scaleAspectFill
        
        followButton.layer.cornerRadius = 10
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = colorPink
        
        if UserManager.getCurrentUser()?.uid == userFrom.uid {
            self.followButton.isHidden = true
        } else {
            self.editProfileButton.isHidden = true
        }
    }
   
    private func uiUserIsFollowButton() {
        let colorPink: CGColor! = CGColor(red: CGFloat(0xFD) / 255.0, green: CGFloat(0x7D) / 255.0, blue: CGFloat(0xFF) / 255.0, alpha: 1)
        followButton.backgroundColor = UIColor(cgColor: colorPink)
        followButton.setTitleColor(.white, for: .normal)
    }
    
    private func uiUserIsntFollowButton() {
        let colorPink: CGColor! = CGColor(red: CGFloat(0xFD) / 255.0, green: CGFloat(0x7D) / 255.0, blue: CGFloat(0xFF) / 255.0, alpha: 1)
        followButton.backgroundColor = .white
        followButton.setTitleColor(UIColor(cgColor: colorPink), for: .normal)
    }
}
