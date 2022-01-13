//
//  NewPostVCViewController.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 23/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView

class NewPostVC: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpElements()
    }
    
    
    func SetUpElements(){
        Utilities.styleFilledButton(addButton)
    }

    @IBAction func addPostButtonClicked(_ sender: Any) {
        if let user = UserManger.loggedInUser{
            addButton.setTitle("", for: .normal)
            loaderView.startAnimating()
            PostAPI.addNewPost(image: postImageTextField.text!, text: postText.text!, userId: user.id){
                self.loaderView.stopAnimating()
                self.addButton.setTitle("Add", for: .normal)
    
                NotificationCenter.default.post(name:  NSNotification.Name("NewPostAdded"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
        }
    }
  }
      
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}


