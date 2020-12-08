//
//  ViewController.swift
//  insta-isil
//
//  Created by Franco Salcedo on 10/4/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_Theming
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginTextField: MDCTextField!
    @IBOutlet weak var passwordLoginTextField: MDCTextField!
    @IBOutlet weak var submitLoginButton: MDCFlatButton!
    @IBOutlet weak var registerLoginButton: MDCButton!
    
    var emailLoginTextFieldController: MDCTextInputControllerOutlined?
    var passwordLoginTextFieldController: MDCTextInputControllerOutlined?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerScheme = globalContainerScheme()
        
        //Login View
        emailLoginTextField.placeholder = "Correo"
        self.emailLoginTextFieldController = MDCTextInputControllerOutlined(textInput: emailLoginTextField)
        self.emailLoginTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        emailLoginTextFieldController?.applyTheme(withScheme: containerScheme)
        
        passwordLoginTextField.placeholder = "Contraseña"
        self.passwordLoginTextFieldController = MDCTextInputControllerOutlined(textInput: passwordLoginTextField)
        self.passwordLoginTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        passwordLoginTextFieldController?.applyTheme(withScheme: containerScheme)
        
        submitLoginButton.setShadowColor(.white, for: .normal)
        submitLoginButton.applyContainedTheme(withScheme: containerScheme)
        
        registerLoginButton.setShadowColor(.white, for: .normal)
        registerLoginButton.applyContainedTheme(withScheme: self.whiteColorScheme())
        registerLoginButton.applyTextTheme(withScheme: containerScheme)
        registerLoginButton.applyOutlinedTheme(withScheme: containerScheme)
        
        //Register View
        
        emailLoginTextField.placeholder = "Correo"
        self.emailLoginTextFieldController = MDCTextInputControllerOutlined(textInput: emailLoginTextField)
        self.emailLoginTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        emailLoginTextFieldController?.applyTheme(withScheme: containerScheme)
        
        passwordLoginTextField.placeholder = "Contraseña"
        self.passwordLoginTextFieldController = MDCTextInputControllerOutlined(textInput: passwordLoginTextField)
        self.passwordLoginTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        passwordLoginTextFieldController?.applyTheme(withScheme: containerScheme)
        
        submitLoginButton.setShadowColor(.white, for: .normal)
        submitLoginButton.applyContainedTheme(withScheme: containerScheme)
        
        registerLoginButton.setShadowColor(.white, for: .normal)
        registerLoginButton.applyContainedTheme(withScheme: self.whiteColorScheme())
        registerLoginButton.applyTextTheme(withScheme: containerScheme)
        registerLoginButton.applyOutlinedTheme(withScheme: containerScheme)
        
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
    
    private func showAlert(title: String,msg: String) {
        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        if let email = emailLoginTextField.text, let pswd = passwordLoginTextField.text {
            Auth.auth().signIn(withEmail: email, password: pswd) { result, error in
                if error == nil {
                    let homeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                    
                    self.view.window?.rootViewController = homeVC
                    self.view.window?.makeKeyAndVisible()
                } else {
                    self.showAlert(title: "Error Login", msg: error?.localizedDescription ?? "No hay descripcion")
                }
            }
        }
    }
    
}

