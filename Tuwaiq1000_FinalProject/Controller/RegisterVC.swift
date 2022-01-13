//
//  RegisterVC.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 18/05/1443 AH.
//

import UIKit
import SwiftMessages
import TextFieldEffects


class RegisterVC: UIViewController {
 
//    MARK: OUTLETS
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var firstNameTextFeild: UITextField!
    @IBOutlet weak var lastNameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
  
    //    MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    SetUpElements()
    
    }
    
// MARK: ACTIONS
    

   
    @IBAction func registerButtonClicked(_ sender: Any) {
        UserAPI.registerNewUser(firstName: firstNameTextFeild.text!, lastName: lastNameTextFeild.text!, email: emailTextFeild.text!) { [self] user, errorMessage in
            
        
            if errorMessage != nil{
                let error = self.ShowErrorAlert(title: "Invalid Register", body: errorMessage!, okButtonTitle: "Try again") { AlertActionType in}
        
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
                let success = self.ShowSuccsesAlert(title: "SUCCESS", body: "Your account has been successfully Created", okButtonTitle: "Done") { _ in AlertActionType.self}
                self.present(vc!, animated: true, completion: nil)
            }
        }

    }
    
    func SetUpElements(){
        Utilities.styleFilledButton(registerButton)
    }

    
    
    
    func ShowSuccsesAlert(title: String, body: String, okButtonTitle: String? , handler: ((AlertActionType) -> Void)?) {
        
        let successAlert = MessageView.viewFromNib(layout: .centeredView) //.tabView).centeredView)
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
    
    
    func ShowErrorAlert(title: String, body: String, okButtonTitle: String, handler: ((AlertActionType) -> Void)?) {
        
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
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }

}

