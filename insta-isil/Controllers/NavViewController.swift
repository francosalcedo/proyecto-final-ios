//
//  NavViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 28/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import FirebaseAuth

class NavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapHome(_ sender: Any) {
        let homeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeVC
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func didTapProfile(_ sender: Any) {
        let profileVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
        
        self.view.window?.rootViewController = profileVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func didTapOnLogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let loginVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
            
            self.view.window?.rootViewController = loginVC
            self.view.window?.makeKeyAndVisible()
        } catch  {
            print("No se pudo Salir sesion de la cuenta")
        }
    }
}
