
import UIKit
import MaterialComponents.MDCFlatButton

class HomeViewController: UIViewController {
    @IBOutlet weak var publishBtn: MDCFlatButton!
    @IBOutlet weak var photoPublishImg: UIImageView!
    @IBOutlet weak var postsCollectionView: UICollectionView!

    var data: [Post] = []
    var postToComment: Post!
    var userToProfile: User!
    
    //MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
        PostManager.getPostsAll{ posts in
            self.data = posts
            self.postsCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComment" {
            guard let commentsVC = segue.destination as? CommentsViewController else { return }
            commentsVC.post = self.postToComment
        } else if segue.identifier == "toProfile" {
            guard let profileVC = segue.destination as? ProfileViewController else { return }
            profileVC.userFrom = self.userToProfile
        }
    }
    
    //MARK: - Functions
    
    func configureComponents() {
        UserManager.getDataFromCurrentUser { user in
            if user != nil {
                let urlImage: String? = user?.imageUrl ?? nil
                if urlImage != nil && urlImage != "" {
                    let url: URL? = URL(string: urlImage!)
                    do {
                        let image_data = try Data(contentsOf: url!)
                        self.photoPublishImg.image = UIImage(data: image_data)
                    } catch {
                        self.photoPublishImg.image = UIImage(named: "user-photo")
                    }
                } else {
                    self.photoPublishImg.image = UIImage(named: "user-photo")
                }
        
                self.photoPublishImg.contentMode = .scaleAspectFill
                self.photoPublishImg.layer.cornerRadius = 30
                self.photoPublishImg.sizeToFit()
                
            } else {
                self.photoPublishImg.image = UIImage(named: "user-photo")
            }
        }
        self.publishBtn.setShadowColor(.white, for: .normal)
        self.publishBtn.applyContainedTheme(withScheme: self.globalContainerScheme())
    }
    
    func globalContainerScheme() -> MDCContainerScheming {
        let containerScheme = MDCContainerScheme()
        containerScheme.colorScheme.primaryColor = UIColor(red: CGFloat(0x00) / 255.0,
                                                           green: CGFloat(0xAE) / 255.0,
                                                           blue: CGFloat(0xEF) / 255.0,
                                                           alpha: 1)
        return containerScheme
    }
}

// MARK: - UICollectionViewDataDelegate
extension HomeViewController: UICollectionViewDelegate {
    //
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell" , for: indexPath) as! PostsCollectionViewCell
        
        let post = data[indexPath.row];
        var user_post: User!
        
        // Get User and Setup UI
        UserManager.getDataFromUserByUId(uid: post.uid!) { user in
            let urlImage: String! = user!.imageUrl
            if urlImage != nil && urlImage != "" {
                let url: URL! = URL(string: urlImage!)
                do {
                    let data = try Data(contentsOf: url)
                    cell.photoUserImageView.image = UIImage(data: data)
                    cell.photoUserImageView.sizeToFit()
                } catch {
                    cell.photoUserImageView.image = UIImage(named: "user-photo")
                }
            } else {
                cell.photoUserImageView.image = UIImage(named: "user-photo")
            }
            
            cell.photoUserImageView.contentMode = .scaleAspectFill
            cell.photoUserImageView.layer.cornerRadius = 20
            
            let user_name = "\(user?.firstname! ?? "") \(user?.lastname! ?? "")"
            
            cell.nameUserLabel.text = user_name
            
            if UserManager.getCurrentUser()?.uid == post.uid {
                cell.deleteButton.isHidden = false
            }
            //get User
            user_post = user
        }
        
        cell.tapLikeButton = {
            cell.likeButton.isEnabled = false
            let user = UserManager.getCurrentUser()
            let uid = user?.uid
            let post_id: String = post.id ?? ""
            PostLikeManager.isLikedByCurrentUser(postId: post_id) { isLiked in
                let p = PostLike(postId: post_id, userId: uid ?? "", isLiked: !isLiked)
                PostLikeManager.setPostLikeToDocument(postLike: p)
                if p.isLiked{
                    cell.setupUILikeButtonIsLiked()
                } else {
                    cell.setupUILikeButtonIsntLiked()
                }
                cell.likeButton.isEnabled = true
            }
        }
        cell.tapCommentButton = {
            self.postToComment = post
        }
        cell.tapProfileButton = {
            self.userToProfile = user_post
        }
        cell.tapDeleteButton = {
            PostManager.deletePostByPostId(post.id!)
            PostManager.getPostsAll{ posts in
                self.data = posts
                self.postsCollectionView.reloadData()
                //self.postsCollectionView.reloadInputViews()
            }
            
        }
        
        //
        cell.deleteButton.isHidden = true
        cell.backgroundColor = .white
        cell.captionTextView.text = post.caption
        PostLikeManager.isLikedByCurrentUser(postId: post.id ?? "") { isLiked in
            if isLiked {
                cell.setupUILikeButtonIsLiked()
            } else {
                cell.setupUILikeButtonIsntLiked()
            }
        }
        return cell
    }
}

