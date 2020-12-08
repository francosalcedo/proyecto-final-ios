//
//  User.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 6/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation

class User {
    var uid: String!
    var firstname: String!
    var lastname: String!
    var carrera: String!
    var sede: String!
    var birthday: String!
    var imageUrl: String!
    
    init(uid: String, firstname: String, lastname: String, carrera: String, sede: String, birthday: String, imageUrl: String) {
        self.uid = uid
        self.firstname = firstname
        self.lastname = lastname
        self.carrera = carrera
        self.sede = sede
        self.birthday = birthday
        self.imageUrl = imageUrl
    }
}
