//
//  EditProfileViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 29/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameTextField: MDCTextField!
    @IBOutlet weak var lastnameTextField: MDCTextField!
    @IBOutlet weak var carreraTextField: MDCTextField!
    @IBOutlet weak var sedeTextField: MDCTextField!
    @IBOutlet weak var birthdayTextField: MDCTextField!
    @IBOutlet weak var submitBtn: MDCFlatButton!
    @IBOutlet weak var returnBtn: MDCFlatButton!
    
    var nameTextFieldController: MDCTextInputControllerOutlined?
    var lastnameTextFieldController: MDCTextInputControllerOutlined?
    var carreraTextFieldController: MDCTextInputControllerOutlined?
    var sedeTextFieldController: MDCTextInputControllerOutlined?
    var birthdayTextFieldController: MDCTextInputControllerOutlined?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureComponents()
        
        
    }
    
    private func configureComponents() {
        let user = Auth.auth().currentUser
        let user_email = user?.email
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user_email ?? "")
        
        self.photoImage.layer.cornerRadius = 90
        
        nameTextField.placeholder = "Nombre"
        self.nameTextFieldController = MDCTextInputControllerOutlined(textInput: nameTextField)
        self.nameTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        nameTextFieldController?.applyTheme(withScheme: globalContainerScheme())
        
        lastnameTextField.placeholder = "Apellidos"
        self.lastnameTextFieldController = MDCTextInputControllerOutlined(textInput: lastnameTextField)
        self.lastnameTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        lastnameTextFieldController?.applyTheme(withScheme: globalContainerScheme())
        
        carreraTextField.placeholder = "Carrera"
        self.carreraTextFieldController = MDCTextInputControllerOutlined(textInput: carreraTextField)
        self.carreraTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        carreraTextFieldController?.applyTheme(withScheme: globalContainerScheme())
        
        sedeTextField.placeholder = "Sede"
        self.sedeTextFieldController = MDCTextInputControllerOutlined(textInput: sedeTextField)
        self.sedeTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        sedeTextFieldController?.applyTheme(withScheme: globalContainerScheme())
        
        birthdayTextField.placeholder = "Cumpleaños"
        self.birthdayTextFieldController = MDCTextInputControllerOutlined(textInput: birthdayTextField)
        self.birthdayTextFieldController?.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        birthdayTextFieldController?.applyTheme(withScheme: globalContainerScheme())
        
        submitBtn.setShadowColor(.white, for: .normal)
        submitBtn.applyContainedTheme(withScheme: globalContainerScheme())
        
        returnBtn.setShadowColor(.white, for: .normal)
        returnBtn.applyContainedTheme(withScheme: redColorScheme())
        
        userRef.getDocument { snapshot, error in
            if let data = snapshot?.data() {
                let name =  "\(data["firstname"] ?? "")"
                let lastname = "\(data["lastname"] ?? "")"
                let carrera = "\(data["carrera"] ?? "")"
                let sede = "\(data["sede"] ?? "")"
                let birthday = "\(data["birthday"] ?? "")"
                self.nameTextField.text = name
                self.lastnameTextField.text = lastname
                self.carreraTextField.text = carrera
                self.sedeTextField.text = sede
                self.birthdayTextField.text = birthday
            }
        }
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        var msg: String = ""
        var errorValidate = false
        
        let name = nameTextField.text
        let lastname = lastnameTextField.text
        let carrera = carreraTextField.text
        let sede = sedeTextField.text
        let birthday = birthdayTextField.text
        
        if name == "" { msg = msg + "\n Nombre no valido o vacio" }
        if lastname == "" { msg = msg + "\n Apellido no valido o vacio" }
        if carrera == "" { msg = msg + "\n Carrera no valido" }
        if sede == "" { msg = msg + "\n Sede Invalido o Vacio" }
        if birthday == "" { msg = msg + "\n Birthday Invalido o Vacio" }
        
        if !(msg == "") {
            errorValidate = true
        } else {
            msg = "Se encontraron Errores:" + msg
        }
        
        if !errorValidate {
            let db = Firestore.firestore()
            let user_email = getUsernameEmail()
            
            db.collection("users").document(user_email ?? "").setData(["firstname": name!, "lastname": lastname!, "carrera": carrera!, "sede": sede!, "birthday": birthday!]) { error in
                if error != nil {
                    self.showAlert(title: "Error Firebase", msg: "No se pudo ingresar datos al storage")
                }
            }
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            let profileVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
            
            self.view.window?.rootViewController = profileVC
            self.view.window?.makeKeyAndVisible()
        } else {
            print("ERROR AL SUBIR DATOS")
        }
        
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
    
    private func getUsernameEmail () -> String? {
        let user = Auth.auth().currentUser
        let user_email = user?.email
        
        return user_email
    }
    @IBAction func didTapReturn(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
}
