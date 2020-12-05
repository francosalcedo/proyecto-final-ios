
import UIKit
import Firebase
import MaterialComponents.MDCFlatButton

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var publishBtn: MDCFlatButton!
    @IBOutlet weak var photoPublishImg: UIImageView!
    @IBOutlet weak var postsCollectionView: UICollectionView!

    var posts_data: [Post] = []
    var postToComment: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            configureComponents()
            PostManager.getPostsByCurrentUser { posts in
                self.posts_data = posts
                self.postsCollectionView.reloadData()
            }
        } else {
            print("No esta online")
            let loginVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
            
            self.view.window?.rootViewController = loginVC
            self.view.window?.makeKeyAndVisible()
        }
        
    }
    
    func configureComponents() {
        let user = Auth.auth().currentUser
        let user_email = user?.email
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user_email ?? "")
        
        userRef.getDocument { snapshot, error in
            if let _ = error {
                self.photoPublishImg.image = UIImage(named: "user-photo")
            } else {
                guard let data = snapshot?.data() else {
                    self.photoPublishImg.image = UIImage(named: "user-photo")
                    return
                }
               
                if data["image-url"] != nil {
                    let url: URL = URL(string: data["image-url"] as! String)!
                    do {
                        let image_data = try Data(contentsOf: url)
                        self.photoPublishImg.image = UIImage(data: image_data)
                    } catch {
                        print("Error al obtener Imagen")
                        self.photoPublishImg.image = UIImage(named: "user-photo")
                    }
                } else {
                    print("Es nill")
                    self.photoPublishImg.image = UIImage(named: "user-photo")
                }
        
                self.photoPublishImg.contentMode = .scaleAspectFill
                self.photoPublishImg.layer.cornerRadius = 30
                self.photoPublishImg.sizeToFit()
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
    //Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell" , for: indexPath) as! PostsCollectionViewCell
        
        let user = Auth.auth().currentUser
        let user_email = user?.email
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user_email ?? "")
        
        userRef.getDocument { snapshot, error in
            if let data = snapshot?.data() {
                let url: URL = URL(string: data["image-url"] as! String)!
                do {
                    let data = try Data(contentsOf: url)
                    cell.photoUserImageView.image = UIImage(data: data)
                    cell.photoUserImageView.sizeToFit()
                } catch {
                    cell.photoUserImageView.image = UIImage(named: "user-photo")
                }
                cell.photoUserImageView.contentMode = .scaleAspectFill
                cell.photoUserImageView.layer.cornerRadius = 20
                
                let user_name = "\(String(describing: data["firstname"] ?? "")) \(String(describing: data["lastname"] ?? ""))"
                
                cell.nameUserLabel.text = user_name
                
            }
            
        }
        cell.tapLikeButton = {
            cell.likeButton.isEnabled = false
            let user = Auth.auth().currentUser
            let uid = user?.uid
            let post_id: String = self.posts_data[indexPath.row].id ?? ""
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
            self.postToComment = self.posts_data[indexPath.row]
        }
        cell.backgroundColor = .white
        cell.captionTextView.text = self.posts_data[indexPath.row].caption
        PostLikeManager.isLikedByCurrentUser(postId: self.posts_data[indexPath.row].id ?? "") { isLiked in
            if isLiked {
                cell.setupUILikeButtonIsLiked()
            } else {
                cell.setupUILikeButtonIsntLiked()
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let commentsVC = segue.destination as? CommentsViewController else { return }
        commentsVC.post = self.postToComment
    }
}
