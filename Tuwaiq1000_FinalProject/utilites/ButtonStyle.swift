//
//  ButtonStyle.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 28/05/1443 AH.
//


import Foundation
import UIKit


class Utilities {
    
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style

        button.backgroundColor = UIColor.init(red:  69/255, green: 115/255, blue: 115/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
   
    }
}
 
