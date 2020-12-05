//
//  Post.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 30/11/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import Foundation
import UIKit

class PostView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setupView()
    }
    
    func setupView () {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        
        //Components
        let photoImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        photoImageView.image = UIImage(named: "user-photo")
        //
        let nameLabel = UILabel(frame: CGRect(
                x: photoImageView.frame.width + photoImageView.frame.origin.x + 20,
                y: photoImageView.frame.origin.y,
                width: 200,
                height: 30
            )
        )
        nameLabel.text = "PEPE \(Int.random(in: 100..<1000))"
        nameLabel.sizeToFit()
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //
        let commentLabel = UILabel(frame: CGRect(
            x: photoImageView.frame.origin.x,
            y: photoImageView.frame.origin.y + photoImageView.frame.height,
            width: 340,
            height: 80
            )
        )
        commentLabel.text = "QWERTYUIPASDFGHJJKL;ZXCVBNMQWERTYUIOPASDFGHJKLZXCVBNMQWERTYUIPASDFGHJJKL;ZXCVBNMQWERTYUIOPASDFGHJKLZXCVBNM"
        //commentLabel.sizeToFit()
        commentLabel.numberOfLines = 0
        commentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        //Add SubView
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(commentLabel)
        
    }
}
