//
//  ShowAlert.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 7/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation
import UIKit

class ShowAlert {
    init(vc: UIViewController, title: String, msg: String) {
        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        vc.present(alertController, animated: true, completion: nil)
    }
}
