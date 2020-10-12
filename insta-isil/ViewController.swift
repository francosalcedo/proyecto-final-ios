//
//  ViewController.swift
//  insta-isil
//
//  Created by Franco Salcedo on 10/4/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var recoveryPasswordButton: UIButton!
    
    private let primaryColor = CGColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10

        loginButton.clipsToBounds = true

        emailTextField.clipsToBounds = true
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = primaryColor

        passwordTextField.clipsToBounds = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = primaryColor
    }

    

}

