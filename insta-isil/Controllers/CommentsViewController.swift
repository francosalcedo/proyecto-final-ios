//
//  CommentsViewController.swift
//  insta-isil
//
//  Created by Aldair Revilla Arroyo on 4/12/20.
//  Copyright © 2020 isil.pe. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postComments_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCollectionViewCell.identifier , for: indexPath) as! CommentsCollectionViewCell
        
        if postComments_data.count >= 0 {
            let user = Auth.auth().currentUser
            
            let user_email = user?.email
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user_email ?? "")
            
            userRef.getDocument { snapshot, error in
                if let data = snapshot?.data() {
                    let url: URL = URL(string: data["image-url"] as! String)!
                    do {
                        let data = try Data(contentsOf: url)
                        cell.userPhotoImageView.image = UIImage(data: data)
                        cell.userPhotoImageView.sizeToFit()
                    } catch {
                        cell.userPhotoImageView.image = UIImage(named: "user-photo")
                    }
                    cell.userPhotoImageView.contentMode = .scaleAspectFill
                    cell.userPhotoImageView.layer.cornerRadius = 30
                    
                    let user_name = "\(String(describing: data["firstname"] ?? "")) \(String(describing: data["lastname"] ?? ""))"
                    let caption: String = "\(user_name) \(self.postComments_data[indexPath.row].caption)"
                    let captionAttributed = NSMutableAttributedString(string: caption as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
                    let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)]
                    
                    captionAttributed.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: user_name.count))
                    cell.captionTextView.text = caption
                    cell.captionTextView.attributedText = captionAttributed
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Navigation
 
    @IBAction func didTapSubmitButton(_ sender: Any) {
        submitButton.isEnabled = false
        let caption = captionTextView.text
        
        if caption != "" && post.id != "" {
            let user = Auth.auth().currentUser
            let uid = user?.uid ?? ""
            
            let postComment = PostComment(id: UUID().uuidString, postId: self.post.id ?? "", caption: caption ?? "", uid: uid)
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
