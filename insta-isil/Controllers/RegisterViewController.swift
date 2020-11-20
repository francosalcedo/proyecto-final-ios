//
//  ViewController.swift
//  insta-isil
//
//  Created by Franco Salcedo on 10/4/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
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
        passwordTextField.autocorrectionType = .no
        
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
    
    private func transitionToHomeVC() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        var msg: String = ""
        var errorValidate = false
        
        let name = nameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if name == "" { msg = msg + "\n Nombre no valido o vacio" }
        if lastname == "" { msg = msg + "\n Apellido no valido o vacio" }
        if email == "" { msg = msg + "\n Correo invalido o vacio" }
        if password == "" { msg = msg + "\n Password Invalido o Vacio" }
        
        if !(msg == "") {
            errorValidate = true
        } else {
            msg = "Se encontraron Errores:" + msg
        }
        
        if !errorValidate {
            Auth.auth().createUser(withEmail: email!, password: password!) { success, error in
                if error == nil {
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": name!, "lastname": lastname!, "uid": success!.user.uid]) { error in
                        if error != nil {
                            self.showAlert(title: "Error Firebase", msg: "No se pudo ingresar datos al storage")
                        }
                    }
                    self.transitionToHomeVC()
                } else {
                    self.showAlert(title: "Error Register", msg: msg)
                }
            }
        }
    }
    
    @IBAction func didTapReturnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
}

