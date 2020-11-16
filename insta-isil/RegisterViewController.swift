//
//  ViewController.swift
//  insta-isil
//
//  Created by Franco Salcedo on 10/4/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_Theming
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: MDCTextField!
    @IBOutlet weak var lastnameTextField: MDCTextField!
    @IBOutlet weak var emailTextField: MDCTextField!
    @IBOutlet weak var passwordTextField: MDCTextField!
    @IBOutlet weak var submitButton: MDCButton!
    @IBOutlet weak var returnButton: MDCButton!
    
    var nameTextFieldController: MDCTextInputControllerOutlined?
    var lastnameTextFieldController: MDCTextInputControllerOutlined?
    var emailTextFieldController: MDCTextInputControllerOutlined?
    var passwordTextFieldController: MDCTextInputControllerOutlined?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let containerScheme = globalContainerScheme()
        
        //Register View
        
        nameTextField.placeholder = "Nombre"
        self.nameTextFieldController = MDCTextInputControllerOutlined(textInput: nameTextField)
        self.nameTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        nameTextFieldController?.applyTheme(withScheme: containerScheme)
        
        lastnameTextField.placeholder = "Apellido"
        self.lastnameTextFieldController = MDCTextInputControllerOutlined(textInput: lastnameTextField)
        self.lastnameTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        lastnameTextFieldController?.applyTheme(withScheme: containerScheme)
        
        emailTextField.placeholder = "Correo"
        self.emailTextFieldController = MDCTextInputControllerOutlined(textInput: emailTextField)
        self.emailTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        emailTextFieldController?.applyTheme(withScheme: containerScheme)
        
        passwordTextField.placeholder = "Contraseña"
        self.passwordTextFieldController = MDCTextInputControllerOutlined(textInput: passwordTextField)
        self.passwordTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        passwordTextFieldController?.applyTheme(withScheme: containerScheme)
        
        submitButton.setShadowColor(.white, for: .normal)
        submitButton.applyContainedTheme(withScheme: containerScheme)
        
        returnButton.setShadowColor(.white, for: .normal)
        returnButton.applyContainedTheme(withScheme: redColorScheme())

    }
    
    func globalContainerScheme() -> MDCContainerScheming {
        let containerScheme = MDCContainerScheme()
        containerScheme.colorScheme.primaryColor = UIColor(red: CGFloat(0x00) / 255.0,
                                                           green: CGFloat(0xAE) / 255.0,
                                                           blue: CGFloat(0xEF) / 255.0,
                                                           alpha: 1)
        return containerScheme
    }
    
    func whiteColorScheme() -> MDCContainerScheming {
        let containerScheme = MDCContainerScheme()
        containerScheme.colorScheme.primaryColor = .white
        return containerScheme
    }
    
    func redColorScheme() -> MDCContainerScheming {
        let containerScheme = MDCContainerScheme()
        containerScheme.colorScheme.primaryColor = UIColor(red: CGFloat(0xFF) / 255.0,
                                                           green: CGFloat(0x44) / 255.0,
                                                           blue: CGFloat(0x44) / 255.0,
                                                           alpha: 1)
        return containerScheme
    }
    @IBAction func didTapSubmitButton(_ sender: Any) {
        print("me pulso")
    }
    @IBAction func didTapReturnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
}

