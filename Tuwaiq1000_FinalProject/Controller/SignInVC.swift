//
//  SigninVC.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 18/05/1443 AH.
//

import UIKit
import Spring
import NVActivityIndicatorView
import SwiftMessages
import TextFieldEffects

final class SignInVC: UIViewController {

    @IBOutlet weak var TitleLabel: SpringLabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var registerButton: SpringButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var firstNameTextFiled: UITextField!
    @IBOutlet weak var lastNameTextfiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            SetUpElements()
            animateIn()
    }
    
    func SetUpElements(){
        Utilities.styleFilledButton(signInButton)
    }

    func animateIn(){
        TitleLabel.animation = "squeezeDown"
        TitleLabel.delay = 0.2
        TitleLabel.duration = 1
        TitleLabel.animate()
    }
    
    func animateOut(user: User?){
        TitleLabel.animation = "squeezeDown"
        TitleLabel.delay = 0.5
        TitleLabel.duration = 1
        TitleLabel.animateTo()
        
        registerButton.animation = "squeezeDown"
        registerButton.delay = 0.5
        registerButton.duration = 1
        registerButton.animateToNext {
            
            
            if let loggedInUser = user {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                UserManger.loggedInUser = loggedInUser
                self.ShowSuccsesAlert(title: "SUCCESS", body: "Logged in successfully." , okButtonTitle: "Done") { AlertActionType in
                    
                }
                self.present(vc!, animated: true, completion: nil)
            }
          
        }
    }
    
    
    func ShowSuccsesAlert(title: String, body: String, okButtonTitle: String , handler: ((AlertActionType) -> Void)?) {
        
        let successAlert = MessageView.viewFromNib(layout: .centeredView)
        successAlert.configureTheme(.success)
        successAlert.configureDropShadow()
        successAlert.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: okButtonTitle){ (_) in
            SwiftMessages.hide()
        }
    
        successAlert.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    var config = SwiftMessages.Config()
    config.dimMode = .gray(interactive: true)
    config.presentationStyle = .center
    config.interactiveHide = false
    
    SwiftMessages.show(config: config, view: successAlert)


    }
    
    
    func ShowErrorAlert(title: String, body: String, okButtonTitle: String?, handler: ((AlertActionType?) -> Void)?) {
        
        let ErrorAlert = MessageView.viewFromNib(layout: .centeredView) 
        ErrorAlert.configureTheme(.error)
        ErrorAlert.configureDropShadow()
        ErrorAlert.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: okButtonTitle){ (_) in
            SwiftMessages.hide()
        }
    
        ErrorAlert.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    var config = SwiftMessages.Config()
    config.dimMode = .gray(interactive: true)
    config.presentationStyle = .center
    config.duration = .forever
    config.interactiveHide = false
    
    SwiftMessages.show(config: config, view: ErrorAlert)


    }
    
    

    @IBAction private func signInButtonClicked(_ sender: Any) {
        loaderView.startAnimating()
        UserAPI.signInUser(firstName: firstNameTextFiled.text!, lastName: lastNameTextfiled.text!) { [self] user, errorMessage in
            
            self.loaderView.stopAnimating()
            if let message = errorMessage {
                let alert = ShowErrorAlert(title: "Invalid login", body: message, okButtonTitle: "Try again") { AlertActionType in }
                }else{
                self.animateOut(user: user)
            }
            
        }
    }
 }
    
    

