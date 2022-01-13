//
//  VideoVC.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 28/05/1443 AH.
//


import UIKit


class HomeVC: UIViewController {
    
  
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpElements()
}
    
    
    func SetUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(signInButton)
    }

}
