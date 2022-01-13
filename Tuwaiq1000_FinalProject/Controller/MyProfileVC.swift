//
//  MyProfileVC.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 25/05/1443 AH.
//

import UIKit
import SwiftMessages
import NVActivityIndicatorView

class MyProfileVC: UIViewController {

    
    
    //MARK: OUTLETS:
    @IBOutlet weak var sumbitButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var loderView: NVActivityIndicatorView!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                setupUI()
            SetUpElements()
    
        
    }
    
    func SetUpElements(){
        Utilities.styleFilledButton(sumbitButton)
    }
    
    func setupUI(){
        userImageView.makeCircularImage()
        if let user = UserManger.loggedInUser {
            if let image = user.picture {
                userImageView.setImageFromStringUrl(stringUrl: image)
            }
            nameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            phoneTextField.text = user.phone
            imageURLTextField.text = user.picture
        }
        
    }
 
    
    func ShowSuccsesAlert(title: String, body: String, okButtonTitle: String? , handler: ((AlertActionType) -> Void)?) {
        let successAlert = MessageView.viewFromNib(layout: .centeredView)
        successAlert.configureTheme(.success)
        successAlert.configureDropShadow()
        successAlert.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: okButtonTitle){ (_) in
            SwiftMessages.hide()
        }
    
        successAlert.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    var config = SwiftMessages.Config()
    config.presentationStyle = .center
    config.interactiveHide = false
    SwiftMessages.show(config: config, view: successAlert)
    }
    
    // MARK: ACTIONS :

     @IBAction func SubmitButtonClicked(_ sender: Any) {
         
         guard let loggedInUser = UserManger.loggedInUser else {return}
         loderView.startAnimating()
         UserAPI.UpdateUserInfo(userId: loggedInUser.id, firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageURLTextField.text!) { user, message in
             self.loderView.stopAnimating()
             if let responseUser = user {
                 if let image = user?.picture {
                     self.userImageView.setImageFromStringUrl(stringUrl: image)
                 }
                 self.nameLabel.text = responseUser.firstName + " " + responseUser.lastName
                 self.phoneTextField.text = responseUser.phone
                 self.ShowSuccsesAlert(title: "SUCCESS", body: "Successfully updated your personal information", okButtonTitle: "Done") { AlertActionType in
                 }
             }
         }
     }
}
