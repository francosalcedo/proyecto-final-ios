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

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: MDCTextField!
    @IBOutlet weak var submitButton: MDCButton!
    
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
}

