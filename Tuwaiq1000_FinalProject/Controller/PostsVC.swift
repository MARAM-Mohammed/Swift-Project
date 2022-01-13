//
//  ViewController.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 09/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView


class PostsVC: UIViewController  {
   
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var newPostButtonContainerView: ShadowView!
    @IBOutlet weak var hiUser: UILabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    
    @IBOutlet weak var lockbutton: UIButton!
    @IBOutlet weak var postsTabelView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagContainerView: UIView!
    @IBOutlet weak var AddPostView: UIButton!{
        didSet{
            AddPostView.layer.cornerRadius = AddPostView.layer.bounds.width / 2
            AddPostView.clipsToBounds = true
        }
    }
    var total = 0
    var page = 0
    var posts : [Post] = []
    var tag: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    NotificationCenter.default.addObserver(self, selector: #selector(postDeleted), name: NSNotification.Name(rawValue: "postDeleted"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name(rawValue: "NewPostAdded"), object: nil)
        
        if let user =  UserManger.loggedInUser {
            hiUser.text = "Hi,\(user.firstName)"
            lockbutton.isHidden = true
        
            
        }else{
            hiUser.isHidden = true
            newPostButtonContainerView.isHidden = true
            logoutButton.isHidden = true
  
        }
        

        if let myTag = tag {
           
            tagNameLabel.text = myTag
            lockbutton.isHidden = true
        
        }else{
            closeButton.isHidden = true
            tagContainerView.isHidden = true
        }
        
        postsTabelView.delegate = self
        postsTabelView.dataSource = self
        
       NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name(rawValue: "userStackViewTapped"), object: nil)
        
            getPosts()
    }

    
    
    func getPosts(){
        loaderView.startAnimating()
        PostAPI.getAllPosts(page: page, tag: tag) { postsResponse , total  in
            self.total = total
            self.posts.append(contentsOf: postsResponse)
            self.postsTabelView.reloadData()
            self.loaderView.stopAnimating()
        }
    }
    

    @objc func postDeleted(){
        self.posts = []
        self.page = 0
        getPosts()
    }
    
    
    @objc func newPostAdded(){
        self.posts = []
        self.page = 0
        getPosts()

}
    
    
    
   // MARK: ACRIONS
    
    /* UIButton :
    ERROR : Unrecognized Selector Sent to Instance  */

    
//    @IBAction func deleteButtonClicked(notification:Notification) {
//
//            let confirm = UIAlertController(title: "Dlete Post", message: "Are you sure you want delete the Post ? ", preferredStyle: .alert)
//        confirm.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.init(red:  255/255, green: 255/255, blue: 255/255, alpha: 1)
//
//        let confiremAction = UIAlertAction(title: "Yes", style: .destructive)
//        confirm.addAction(confiremAction)
//    if let cell = notification.userInfo?["cell"] as? UITableViewCell {
//            if let indexPath = postsTabelView.indexPath(for: cell){
//                let post = posts[indexPath.row]
//                let currentPost = posts[indexPath.row]
//                if let user = UserManger.loggedInUser{
//                    if currentPost.id == user.id {
//                        PostAPI.postDelete(postId: currentPost.id, userId: user.id) {
//                        }
//                        NotificationCenter.default.addObserver(self, selector: #selector(postDeleted), name: NSNotification.Name(rawValue: "postDeleted"), object: nil)
//                        self.dismiss(animated: true, completion: nil)
//                        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
//                        confirm.addAction(cancelAction)
//                        self.present(confirm , animated: true, completion: nil)
//                    }
//                }
//            }
//    }
//    }
   


    
    @IBAction func logoutButton(_ sender: Any) {
       
        let logoutAlert = UIAlertController(title: "Log out", message: "Are you sure to log out ? ", preferredStyle: .alert)
        logoutAlert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.init(red:  164/255, green: 205/255, blue: 181/255, alpha: 1)
        logoutAlert.view.tintColor =  UIColor.init(red:  37/255, green: 75/255, blue: 90/255, alpha: 1)
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive) { [self] alert in
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            present(vc, animated: true, completion: nil)
    }
        logoutAlert.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        logoutAlert.addAction(cancelAction)
        present(logoutAlert , animated: true, completion: nil)
        UserManger.loggedInUser = nil
    }

   

    // MARK: HERE

    @objc func userProfileTapped(notification: Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postsTabelView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                vc.user = post.owner
            present(vc, animated: true, completion: nil)
    }
}
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonClicke(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PostsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

        let post = posts[indexPath.row]
        cell.postTextLabel.text = post.text
        
        // the logic of filling the Post's  image from the url
        let imageStringUrl = post.image
        cell.postImageView.setImageFromStringUrl(stringUrl: imageStringUrl)
        
 
        let userImageStringUrl = post.owner.picture
        cell.userImageView.makeCircularImage()
        
        if let image = userImageStringUrl {
            cell.userImageView.setImageFromStringUrl(stringUrl: image)
            
        }
      
        // filling the user data
        
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.likesNumberLabel.text = String(post.likes)
        
        cell.tags = post.tags ?? []
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 560
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostsDetailsVC") as! PostsDetailsVC
        vc.post = selectedPost
         present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1  && posts.count < total {
          page = page + 1
          getPosts()
        }
    }
}

