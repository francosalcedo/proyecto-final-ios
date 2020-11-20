//
//  ViewController.swift
//  insta-isil
//
//  Created by Franco Salcedo on 10/4/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import FirebaseAuth
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_Theming
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: MDCTextField!
    @IBOutlet weak var submitButton: MDCButton!
    @IBOutlet weak var returnButton: MDCButton!
    
    
    var emailTextFieldController: MDCTextInputControllerOutlined?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let containerScheme = globalContainerScheme()
        
        //View

        emailTextField.placeholder = "Correo"
        self.emailTextFieldController = MDCTextInputControllerOutlined(textInput: emailTextField)
        self.emailTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        emailTextFieldController?.applyTheme(withScheme: containerScheme)
        
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
    
    private func showAlert(title: String,msg: String) {
        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        var isEmailValid = true
            
        let email = emailTextField.text
        
        if email == "" {isEmailValid = false}
        
        if isEmailValid {
            Auth.auth().sendPasswordReset(withEmail: email!) { error in
                if error == nil {
                    self.navigationController?.popViewController(animated: true)

                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Error Forget Password", msg: "No se encontro el correo")
                }
            }
              // An error happened.
        } else {
            showAlert(title: "Error Forget Password", msg: "El correo es invalido o esta vacio")
        }
        
        
    }
    
    
    @IBAction func didTapReturnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
}

