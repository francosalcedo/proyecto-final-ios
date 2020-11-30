
import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var PostsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            for i in 1...10{
                let post = PostView()
                PostsStackView.addArrangedSubview(post)
                //post.translatesAutoresizingMaskIntoConstraints = false
                post.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                post.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                post.heightAnchor.constraint(equalToConstant: 150).isActive = true
            }
            configurePostsStackView()
        } else {
            print("No esta online")
            let loginVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
            
            self.view.window?.rootViewController = loginVC
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    
    private func configurePostsStackView() {
        PostsStackView.axis = .vertical
        //PostsStackView.distribution = .fillEqually
        PostsStackView.spacing = 20
    }
}
