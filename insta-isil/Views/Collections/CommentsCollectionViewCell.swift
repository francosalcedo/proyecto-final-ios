//
//  CommentsCollectionViewCell.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    static let identifier = "commentCell"
    
}
