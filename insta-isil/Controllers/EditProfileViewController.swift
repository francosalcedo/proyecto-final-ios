//
//  EditProfileViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 29/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import MaterialComponents

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var changePhotoBtn: UIButton!
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
    
    private let storage = Storage.storage().reference()
    
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
        self.photoImage.contentMode = .scaleAspectFill
        
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
                
                if let imageUrlString: String = data["image-url"] as? String {
                    let url:URL? = URL(string: imageUrlString)
                    do {
                        let data = try Data(contentsOf: url!)
                        self.photoImage.image = UIImage(data: data)
                        self.photoImage.sizeToFit()
                    } catch {
                        print("No encontre Imagen en la url papuh")
                        self.photoImage.image = UIImage(named: "user-photo")
                    }
                } else {
                    print("No se consiguio imagen papuh")
                    self.photoImage.image = UIImage(named: "user-photo")
                }
                
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
            
            db.collection("users").document(user_email ?? "").updateData(["firstname": name!, "lastname": lastname!, "carrera": carrera!, "sede": sede!, "birthday": birthday!]) { error in
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
    @IBAction func didTapPickerImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }

        let imgName = "\(UUID().uuidString).png"
        
        let ref = storage.child("user-photos").child(imgName)
        
        ref.putData(imageData, metadata: nil) { _, err in
            guard err == nil else {
                print("Failed Uploaded Image")
                return
            }
            ref.downloadURL() { url, err in
                if let _ = err {
                    print("Failed Downloade Image")
                    return
                }
                guard let url = url else {
                    print("Failed get Image downloaded")
                    return
                }
                
                let urlString = url.absoluteString
                let urlUrl = url.absoluteURL
                
                let user = Auth.auth().currentUser
                let db = Firestore.firestore()
                let user_email = user?.email
                db.collection("users").document(user_email ?? "").updateData(["image-url": urlString])
                
                do {
                    let data = try Data(contentsOf: urlUrl)
                    self.photoImage.image = UIImage(data: data)
                } catch {
                    self.photoImage.image = UIImage(named: "user-photo")
                }
                self.photoImage.contentMode = .scaleAspectFill
                self.photoImage.layer.cornerRadius = 90
            }
        }
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
