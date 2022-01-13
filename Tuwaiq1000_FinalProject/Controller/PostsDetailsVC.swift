//
//  PostsDetailsVCViewController.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 11/05/1443 AH.
//
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView


class PostsDetailsVC: UIViewController {
   
    var post: Post!
    var comments: [Comment] = []
   

    // MARK: OUTLETS

    @IBOutlet weak var DeleteViewContainer: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentTabelView: UITableView!
    @IBOutlet weak var exitButton: UIButton!{
        didSet{
            exitButton.layer.cornerRadius
            exitButton.layer.bounds.width / 2
            exitButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var newCommentStackView: UIStackView!
    

    // MARK: LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.didReceiveMemoryWarning()

       
        if let user = UserManger.loggedInUser{
            if post.owner.id != user.id {
           DeleteViewContainer.isHidden = true
            }
        }
        
        if UserManger.loggedInUser == nil {
            newCommentStackView.isHidden = true
            DeleteViewContainer.isHidden = true
        }
        
        commentTabelView.delegate = self
        commentTabelView.dataSource = self
        
        exitButton.layer.cornerRadius = exitButton.layer.frame.width / 2
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        postTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
        
        if let image = post.owner.picture{
            userImageView.setImageFromStringUrl(stringUrl: image)
        }
       
        postImageView.setImageFromStringUrl(stringUrl: post.image)
        userImageView.makeCircularImage()
        getAllComments()
     
    }
    
     
    
    func getAllComments(){
        loaderView.startAnimating()
        PostAPI.getPostComments(id: post.id) { commentResponse in
            self.comments = commentResponse
            self.commentTabelView.reloadData()
            self.loaderView.stopAnimating()
            
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


    @IBAction func deletePostButton() {
        if let user = UserManger.loggedInUser{
            if post.owner.id == user.id {
            PostAPI.postDelete(postId: post.id, userId: user.id) {
                NotificationCenter.default.post(name: NSNotification.Name("postDeleted"), object:nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
            }
            }
        }
        }
      
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let message = commentTextField.text!
        if let user = UserManger.loggedInUser{
            loaderView.startAnimating()
            PostAPI.addBNewCommentToPost(postId: post.id, userId: user.id, message: message) {
                self.getAllComments()
                self.commentTextField.text = ""
        }
    }
    
}
}

  
 
extension PostsDetailsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       

        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        let currentComment = comments[indexPath.row]
        
        cell.userNameLabel.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
        cell.commentMessageLabel.text = currentComment.message
        
        
        if let userImage = currentComment.owner.picture {
            cell.userImageView.setImageFromStringUrl(stringUrl: currentComment.owner.picture!)
        }
       
        cell.userImageView.makeCircularImage()
        return cell
    }
    
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
