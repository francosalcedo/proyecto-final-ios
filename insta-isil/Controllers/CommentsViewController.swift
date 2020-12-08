//
//  CommentsViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentsCollectionView: UICollectionView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var post: Post = Post(id: "", uid: "", caption: "")
    var postComments_data: [PostComment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostCommentManager.getPostCommentsByPostId(postId: post.id ?? "") { postComments in
            self.postComments_data = postComments
            self.commentsCollectionView.reloadData()
        }
    }
    
    // MARK: - Action
 
    @IBAction func didTapSubmitButton(_ sender: Any) {
        submitButton.isEnabled = false
        let caption = captionTextView.text
        
        if caption != "" && post.id != "" {
            let uid = UserManager.getCurrentUser()?.uid
            
            let postComment = PostComment(id: UUID().uuidString, postId: self.post.id ?? "", caption: caption ?? "", uid: uid!)
            PostCommentManager.setPostCommentToDocument(postComment: postComment)
            commentsCollectionView.reloadData()
        }
        submitButton.isEnabled = true
    }
    
    @IBAction func didTapReturnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource

extension CommentsViewController: UICollectionViewDataSource {
    //
}

//MARK: - UICollectionViewDelegate

extension CommentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postComments_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCollectionViewCell.identifier , for: indexPath) as! CommentsCollectionViewCell
        
        let post_comment = self.postComments_data[indexPath.row]
        
        
        if postComments_data.count >= 0 {
            
            UserManager.getDataFromUserByUId(uid: post_comment.uid) { user in
                let url: URL = URL(string: "\(user?.imageUrl! ?? "")")!
                do {
                    let data = try Data(contentsOf: url)
                    cell.userPhotoImageView.image = UIImage(data: data)
                    cell.userPhotoImageView.sizeToFit()
                } catch {
                    cell.userPhotoImageView.image = UIImage(named: "user-photo")
                }
                cell.userPhotoImageView.contentMode = .scaleAspectFill
                cell.userPhotoImageView.layer.cornerRadius = 3
                
                let user_name = "\(user?.firstname ?? "") \(user?.lastname ?? "")"
                let caption: String = "\(user_name) \(post_comment.caption)"
                let captionAttributed = NSMutableAttributedString(string: caption as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
                let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)]
                
                captionAttributed.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: user_name.count))
                cell.captionTextView.text = caption
                cell.captionTextView.attributedText = captionAttributed
            }
        }
        
        return cell
    }
    
}
