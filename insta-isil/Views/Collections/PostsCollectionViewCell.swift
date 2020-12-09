//
//  PostsCollectionViewCell.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 2/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoUserImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let identifier = "postCell"
    
    var tapLikeButton: (() -> Void)? = nil
    var tapCommentButton: (() -> Void)? = nil
    var tapProfileButton: (() -> Void)? = nil
    var tapDeleteButton: (() -> Void)? = nil

    func setupUILikeButtonIsLiked () {
        likeButton.layer.backgroundColor = CGColor(red: CGFloat(0x00) / 255.0,
                                               green: CGFloat(0xAE) / 255.0,
                                               blue: CGFloat(0xEF) / 255.0,
                                               alpha: 1)
        likeButton.layer.cornerRadius = 5
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        likeButton.tintColor = .white
    }
    
    func setupUILikeButtonIsntLiked () {
        likeButton.layer.borderWidth = 1
        likeButton.layer.borderColor = CGColor(red: CGFloat(0x00) / 255.0,
                                               green: CGFloat(0xAE) / 255.0,
                                               blue: CGFloat(0xEF) / 255.0,
                                               alpha: 1)
        likeButton.layer.cornerRadius = 5
        likeButton.backgroundColor = .white
        likeButton.tintColor = UIColor(cgColor: CGColor(red: CGFloat(0x00) / 255.0,
                                       green: CGFloat(0xAE) / 255.0,
                                       blue: CGFloat(0xEF) / 255.0,
                                       alpha: 1)
        )
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
    }
    
    //MARK: - Action
    @IBAction func didTapOnLikeButton(_ sender: UIButton!) {
        tapLikeButton?()
    }
    @IBAction func didTapOnCommentButton(_ sender: UIButton!) {
        tapCommentButton?()
    }
    @IBAction func didTapOnProfileButton(_ sender: UIButton!) {
        tapProfileButton?()
    }
    @IBAction func didTapOnDeleteButton(_ sender: UIButton!) {
        tapDeleteButton?()
    }
}
